set $mod Mod4
font pango:FiraMono Nerd Font Mono 10
floating_modifier $mod

set $ws_1 "1"
set $ws_2 "2"
set $ws_3 "3"
set $ws_10 "10"

#i3-msg 'workspace $ws_1 exec termite; workspace $ws_2 exec /usr/bin/firefox'

# start a termina
bindsym $mod+Return exec termite

# focus follows mouse
focus_follows_mouse no

# kill focused window
bindsym $mod+q kill

# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop
bindsym $mod+d exec rofi -show drun

# change focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+s split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# change container layout (stacked, tabbed, toggle split)
bindsym $mod+Shift+s layout stacking
bindsym $mod+Shift+w layout tabbed
bindsym $mod+Shift+e layout toggle split

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# switch to workspace
bindsym $mod+1 workspace $ws_1
bindsym $mod+2 workspace $ws_2
bindsym $mod+3 workspace $ws_3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace $ws_10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $ws_1
bindsym $mod+Shift+2 move container to workspace $ws_2
bindsym $mod+Shift+3 move container to workspace $ws_3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace $ws_10

# reload the configuration file
bindsym $mod+Shift+c reload

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# exit i3 (logs you out of your X session)
bindsym $mod+Shift+z exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# lock
bindsym $mod+Shift+x exec --no-startup-id i3exit lock
exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
exec --no-startup-id nm-applet

# sleep
set $mode_system System (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown
mode "$mode_system" {
    bindsym e exec --no-startup-id i3exit logout, mode "default"
    bindsym s exec --no-startup-id i3exit suspend, mode "default"
    bindsym h exec --no-startup-id i3exit hibernate, mode "default"
    bindsym r exec --no-startup-id i3exit reboot, mode "default"
    bindsym Shift+s exec --no-startup-id i3exit shutdown, mode "default"

    # back to normal: Enter or Escape
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+Shift+v mode "$mode_system"

# resize window (you can also use the mouse for that)
mode "resize" {
    bindsym h resize shrink width 10 px or 10 ppt
    bindsym j resize grow height 10 px or 10 ppt
    bindsym k resize shrink height 10 px or 10 ppt
    bindsym l resize grow width 10 px or 10 ppt
    bindsym Left resize shrink width 10 px or 10 ppt
    bindsym Down resize grow height 10 px or 10 ppt
    bindsym Up resize shrink height 10 px or 10 ppt
    bindsym Right resize grow width 10 px or 10 ppt
    bindsym Return mode "default"
    bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

hide_edge_borders smart

for_window [class="^.*"] border pixel 1
for_window [class="sxiv"] floating enable
for_window [window_role="pop-up"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [window_role="Preferences$"] floating enable
for_window [floating] border pixel 1

# Specific Workspace Assignments
assign [class="firefox"] $ws_2
for_window [class="Spotify"] move to workspace $ws_10
assign [class="Signal"] $ws_3
assign [class="Telegram"] $ws_3
assign [class="Slack"] $ws_3
assign [class="KeePassXC"] 4

# Gaps
gaps top 30
gaps bottom 30
gaps inner 5
smart_borders no_gaps

bindsym $mod+plus		gaps outer current plus 5
bindsym $mod+Shift+plus gaps inner current plus 5
bindsym $mod+minus gaps inner current minus 5
bindsym $mod+Shift+minus gaps outer current minus 5

## Multimedia Keys

# volume
bindsym $mod+F1 exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle
bindsym $mod+F2 exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym $mod+F3 exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%

# Screen brightness controls
bindsym $mod+F12 exec --no-startup-id brightness -inc 5
bindsym $mod+F11 exec --no-startup-id brightness -dec 5

# App shortcuts
bindsym $mod+w exec "/usr/bin/firefox"
bindsym $mod+n exec termite -e ranger
bindsym $mod+p exec keepassxc
bindcode $mod+49 exec "networkmanager_dmenu"
bindsym $mod+t exec "/usr/bin/slack"
bindsym --release $mod+z exec "scrot -s ~/screenshots/%b%d_%H%M%S.png"

# dmenu shortcuts
bindsym $mod+c exec = --dmenu=dmenu
# outputs clipboard manager to dmenu and copies selection to clipboard
bindsym $mod+b exec CM_LAUNCHER=rofi clipmenu

# Autostart apps
exec --no-startup-id betterlockscreen -w dim
exec_always --no-startup-id xset r rate 200 60
exec_always --no-startup-id feh --bg-scale ~/wallpaper.jpg
exec --no-startup-id "clipmenud"
exec --no-startup-id unclutter
exec_always --no-startup-id "compton -b --respect-prop-shadow"
exec --no-startup-id "sleep 5s && dunst -config ~/.config/dunstrc"

#bar {
#    status_command i3status
#    position bottom
#    colors {
#        background #3c3836
#        statusline #ebdbb2
#        separator  #666666
#        focused_workspace  #458588 #458588 #ebdbb2
#        active_workspace   #83a598 #83a598 #ebdbb2
#        inactive_workspace #504945 #504945 #ebdbb2
#        urgent_workspace   #cc241d #cc241d #504945
#    }
#}

exec_always --no-startup-id $HOME/.config/polybar/launch.sh

client.focused          #665c54 #665c54 #eddbb2 #2e9ef4   #665c54
client.focused_inactive #282828 #5f676a #ffffff #484e50   #5f676a
client.unfocused        #3c3836 #3c3836 #a89984 #292d2e   #222222
client.urgent           #cc241d #cc241d #ebdbb2 #cc241d   #cc241d
client.placeholder      #000000 #0c0c0c #ffffff #000000   #0c0c0c

client.background       #ffffff
