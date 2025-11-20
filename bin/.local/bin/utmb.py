import datetime
import os
import subprocess
import time

import requests

# Competition IDs → (Race Name, URL)
COMPETITIONS = {
    "68de87bcc264925fc5ade771": (
        "Mittenwald Trail",
        "https://in.de.byutmb.world/2026-zugspitz-ultra-trail-by-utmb?currentPage=select-competition#competition_68de87bcc264925fc5ade771",
    ),
    "68de876dc264925fc5addf93": (
        "Leutasch Trail",
        "https://in.de.byutmb.world/2026-zugspitz-ultra-trail-by-utmb?currentPage=select-competition#competition_68de876dc264925fc5addf93",
    ),
}

AVAILABILITY_URL = (
    "https://front-api.de.byutmb.world/competition/join-team-availability/{}"
)

HEADERS = {
    "User-Agent": "Mozilla/5.0",
    "Accept": "application/json",
}


def check_availability(comp_id):
    url = AVAILABILITY_URL.format(comp_id)
    r = requests.get(url, headers=HEADERS)
    r.raise_for_status()
    return r.json().get("isAvailable", False)


def notify(title, message, url=None):
    """
    Show a macOS notification using terminal-notifier.
    Opens the given URL when clicked.
    """
    args = ["terminal-notifier", "-title", title, "-message", message]

    if url:
        args += ["-open", url]

    subprocess.run(args)


def main():
    last_state = {cid: None for cid in COMPETITIONS}

    while True:
        now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        print(f"\n[{now}] Checking…")

        summary_lines = []

        for cid, (name, url) in COMPETITIONS.items():
            try:
                available = check_availability(cid)
            except Exception as e:
                summary_lines.append(f"{name}: ERROR ({e})")
                continue

            status_str = "AVAILABLE" if available else "not available"
            summary_lines.append(f"{name}: {status_str}")

            prev = last_state[cid]

            # Race becomes available → highlight
            if available and prev is False:
                notify("UTMB Registration", f"{name} is now OPEN!", url)

            last_state[cid] = available

        # Produce summary notification
        summary = "\n".join(summary_lines)
        notify(
            "UTMB Check",
            summary,
            "https://in.de.byutmb.world/2026-zugspitz-ultra-trail-by-utmb?currentPage=select-competition",
        )

        for line in summary_lines:
            print("  " + line)

        time.sleep(10)


if __name__ == "__main__":
    main()
