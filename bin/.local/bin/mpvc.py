#!/usr/bin/env python3
"""
mpvc - YouTube Music CLI Player with WebSocket server
Usage: mpvc.py [command] [args]
"""

# Check if websockets is available, if not, guide user
try:
    import websockets
except ImportError:
    print("❌ 'websockets' module not found.")
    print("\nInstall it with:")
    print("  pip3 install --user --break-system-packages websockets")
    import sys
    sys.exit(1)

import asyncio
import json
import subprocess
import sys
import os
import signal
import random
from pathlib import Path

SOCKET = "/tmp/mpvsocket"
WS_PORT = 26538
WS_PID_FILE = "/tmp/mpvc-ws.pid"
BROWSER = "firefox"

class MPVController:
    def __init__(self, socket_path=SOCKET):
        self.socket_path = socket_path

    def _send_command(self, command):
        """Send command to mpv via IPC socket"""
        if not os.path.exists(self.socket_path):
            return None

        try:
            cmd_json = json.dumps({"command": command})
            result = subprocess.run(
                f"echo '{cmd_json}' | socat - {self.socket_path}",
                shell=True,
                capture_output=True,
                text=True,
                timeout=1
            )
            if result.stdout:
                return json.loads(result.stdout)
        except Exception as e:
            print(f"Error sending command: {e}", file=sys.stderr)
        return None

    def get_property(self, property_name):
        """Get a property from mpv"""
        response = self._send_command(["get_property", property_name])
        if response and "data" in response:
            return response["data"]
        return None

    def set_property(self, property_name, value):
        """Set a property in mpv"""
        self._send_command(["set_property", property_name, value])

    def cycle_property(self, property_name):
        """Cycle a property in mpv"""
        self._send_command(["cycle", property_name])

    def get_status(self):
        """Get current playback status"""
        if not os.path.exists(self.socket_path):
            return {"error": "mpv not running"}

        try:
            title = self.get_property("media-title") or "Unknown"

            # Filter out URLs and playlist IDs from title
            if any(x in title for x in ["http", "PLU8", "ytsearch", "watch?v="]):
                title = self.get_property("filename") or title

            artist = self.get_property("metadata/by-key/Artist") or "Unknown Artist"
            position = float(self.get_property("playback-time") or 0)
            duration = float(self.get_property("duration") or 0)
            paused = self.get_property("pause") or False
            volume = float(self.get_property("volume") or 100)

            progress = int((position / duration * 100)) if duration > 0 else 0

            return {
                "title": title,
                "artist": artist,
                "position": int(position),
                "duration": int(duration),
                "playing": not paused,
                "volume": int(volume),
                "progress": progress
            }
        except Exception as e:
            return {"error": str(e)}

    def play_pause(self):
        """Toggle play/pause"""
        self.cycle_property("pause")

    def next_track(self):
        """Skip to next track"""
        self._send_command(["playlist-next"])

    def prev_track(self):
        """Go to previous track"""
        self._send_command(["playlist-prev"])

    def shuffle(self):
        """Shuffle playlist using multiple methods"""
        # Get playlist count
        playlist_count = self.get_property("playlist-count")

        if not playlist_count or playlist_count <= 1:
            print("No playlist to shuffle", file=sys.stderr)
            return

        # Get current position
        current_pos = self.get_property("playlist-pos") or 0

        # Method 1: Try built-in shuffle command
        result = self._send_command(["playlist-shuffle"])

        # Method 2: If that doesn't work, manually shuffle by moving items
        if result is None or result.get("error"):
            # Create a list of indices excluding current
            indices = list(range(playlist_count))
            indices.remove(current_pos)
            random.shuffle(indices)

            # Move items to randomize playlist
            for new_pos, old_pos in enumerate(indices, start=1):
                if old_pos != new_pos:
                    self._send_command(["playlist-move", old_pos, new_pos])

        return True

    def seek(self, seconds):
        """Seek by seconds (can be negative)"""
        self._send_command(["seek", str(seconds)])

    def set_volume(self, volume):
        """Set volume (0-100)"""
        self.set_property("volume", volume)

    def quit(self):
        """Quit mpv"""
        self._send_command(["quit"])


class WebSocketServer:
    def __init__(self, port=WS_PORT):
        self.port = port
        self.mpv = MPVController()
        self.clients = set()
        self.update_task = None

    async def register(self, websocket):
        """Register a new client"""
        self.clients.add(websocket)
        # Send initial status
        status = self.mpv.get_status()
        await websocket.send(json.dumps(status))

    async def unregister(self, websocket):
        """Unregister a client"""
        self.clients.discard(websocket)

    async def broadcast(self, message):
        """Broadcast message to all clients"""
        if self.clients:
            await asyncio.gather(
                *[client.send(json.dumps(message)) for client in self.clients],
                return_exceptions=True
            )

    async def handle_client(self, websocket):
        """Handle WebSocket client connection (no path argument for newer websockets)"""
        await self.register(websocket)
        try:
            async for message in websocket:
                try:
                    data = json.loads(message)

                    if "command" in data:
                        command = data["command"]

                        # Execute command
                        if command[0] == "cycle" and command[1] == "pause":
                            self.mpv.play_pause()
                        elif command[0] == "playlist-next":
                            self.mpv.next_track()
                        elif command[0] == "playlist-prev":
                            self.mpv.prev_track()
                        elif command[0] == "playlist-shuffle":
                            self.mpv.shuffle()
                        elif command[0] == "seek":
                            self.mpv.seek(int(command[1]))
                        elif command[0] == "set_property" and command[1] == "volume":
                            self.mpv.set_volume(int(command[2]))

                        # Wait a bit and broadcast new status
                        await asyncio.sleep(0.1)
                        status = self.mpv.get_status()
                        await self.broadcast(status)

                except Exception as e:
                    print(f"Error handling message: {e}", file=sys.stderr)
        finally:
            await self.unregister(websocket)

    async def status_updater(self):
        """Periodically broadcast status updates"""
        while True:
            await asyncio.sleep(1)
            if self.clients:
                status = self.mpv.get_status()
                await self.broadcast(status)

    async def start(self):
        """Start the WebSocket server"""
        print(f"🌐 WebSocket server starting on ws://localhost:{self.port}")

        async with websockets.serve(self.handle_client, "localhost", self.port):
            self.update_task = asyncio.create_task(self.status_updater())
            await asyncio.Future()  # Run forever


def start_ws_server():
    """Start WebSocket server in background"""
    pid_file = Path(WS_PID_FILE)

    # Check if already running
    if pid_file.exists():
        try:
            old_pid = int(pid_file.read_text().strip())
            os.kill(old_pid, 0)  # Check if process exists
            print(f"🌐 WebSocket server already running (PID: {old_pid})")
            return
        except (ProcessLookupError, ValueError):
            pid_file.unlink()

    # Start server
    pid = os.fork()
    if pid == 0:
        # Child process - redirect output to log file
        try:
            server = WebSocketServer(WS_PORT)
            asyncio.run(server.start())
        except Exception as e:
            with open("/tmp/mpvc-ws-error.log", "a") as f:
                f.write(f"WebSocket server error: {e}\n")
            sys.exit(1)
    else:
        # Parent process
        pid_file.write_text(str(pid))
        print(f"🌐 WebSocket server started: ws://localhost:{WS_PORT} (PID: {pid})")


def stop_ws_server():
    """Stop WebSocket server"""
    pid_file = Path(WS_PID_FILE)

    if pid_file.exists():
        try:
            pid = int(pid_file.read_text().strip())
            os.kill(pid, signal.SIGTERM)
            print(f"✓ WebSocket server stopped (PID: {pid})")
        except (ProcessLookupError, ValueError):
            pass
        pid_file.unlink()


def play_music(url_or_search):
    """Start playing music"""
    if url_or_search.startswith("http"):
        url = url_or_search
    else:
        url = f"ytsearch1:{url_or_search}"

    # Start WebSocket server
    start_ws_server()

    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print("🎵 Starting YouTube Music Player")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print(f"🌐 WebSocket: ws://localhost:{WS_PORT}")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    print()

    def cleanup(signum, frame):
        print("\n🛑 Stopping...")
        stop_ws_server()
        sys.exit(0)

    signal.signal(signal.SIGINT, cleanup)
    signal.signal(signal.SIGTERM, cleanup)

    try:
        subprocess.run([
            "mpv",
            "--no-video",
            "--ytdl-format=bestaudio",
            f"--ytdl-raw-options=cookies-from-browser={BROWSER}",
            f"--input-ipc-server={SOCKET}",
            url
        ])
    finally:
        cleanup(None, None)


def main():
    """Main entry point"""
    if len(sys.argv) < 2:
        print("""mpvc - YouTube Music CLI Player

USAGE:
    mpvc play <URL or search>    Start playing
    mpvc <command>               Control playback

EXAMPLES:
    mpvc play "https://music.youtube.com/playlist?list=..."
    mpvc play "radiohead creep"
    mpvc next
    mpvc shuffle
""")
        return

    mpv = MPVController()
    command = sys.argv[1]

    if command in ["play"]:
        if len(sys.argv) < 3:
            print("Usage: mpvc play <URL or search>")
            return
        play_music(" ".join(sys.argv[2:]))

    elif command in ["pause", "pp", "toggle"]:
        mpv.play_pause()
        print("⏯️  Toggled play/pause")

    elif command in ["next", "n"]:
        mpv.next_track()
        print("⏭️  Next track")

    elif command in ["prev", "p"]:
        mpv.prev_track()
        print("⏮️  Previous track")

    elif command in ["shuffle", "shuf", "s"]:
        mpv.shuffle()
        print("🔀 Playlist shuffled")

    elif command in ["stop", "quit"]:
        mpv.quit()
        stop_ws_server()
        print("⏹️  Stopped")

    elif command in ["status", "info", "current"]:
        status = mpv.get_status()
        if "error" in status:
            print(f"❌ {status['error']}")
        else:
            print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
            print(f"🎵 {status['title']}")
            if status['artist'] != "Unknown Artist":
                print(f"🎤 {status['artist']}")
            print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
            state = "▶️ Playing" if status['playing'] else "⏸️  Paused"
            print(state)
            pos_min, pos_sec = divmod(status['position'], 60)
            dur_min, dur_sec = divmod(status['duration'], 60)
            print(f"⏱️  Time: {pos_min:02d}:{pos_sec:02d} / {dur_min:02d}:{dur_sec:02d}")

    elif command == "start-ws":
        start_ws_server()

    elif command == "stop-ws":
        stop_ws_server()

    else:
        # Try to play as search
        play_music(" ".join(sys.argv[1:]))


if __name__ == "__main__":
    main()
