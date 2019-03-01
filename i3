set $mod Mod4
font pango:DejaVu Sans Mono, Icons 10
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec termite

# focus follows mouse
focus_follows_mouse no

# kill focused window
bindsym $mod+q kill

bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

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

# focus the parent container
bindsym $mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

# switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace 1
bindsym $mod+Shift+2 move container to workspace 2
bindsym $mod+Shift+3 move container to workspace 3
bindsym $mod+Shift+4 move container to workspace 4
bindsym $mod+Shift+5 move container to workspace 5
bindsym $mod+Shift+6 move container to workspace 6
bindsym $mod+Shift+7 move container to workspace 7
bindsym $mod+Shift+8 move container to workspace 8
bindsym $mod+Shift+9 move container to workspace 9
bindsym $mod+Shift+0 move container to workspace 10

# reload the configuration file
bindsym $mod+Shift+c reload

# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+r restart

# exit i3 (logs you out of your X session)
bindsym $mod+Shift+z exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

# lock
bindsym $mod+Shift+x exec i3lock --color 141414 --ignore-empty-password --show-failed-attempts

# sleep
set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown
mode "$mode_system" {
    bindsym l exec --no-startup-id i3exit lock, mode "default"
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


# window colors
# class                 border  backgr. text    indicator child border
client.placeholder      #000000 #0C0C0C #FFFFFF #000000   #0C0C0C

# Start i3bar to display a workspace bar (plus the system information i3status
bar {
  status_command i3status
  height 40
  font pango:DejaVu Sans Mono, Icons 10
  position top
  colors {
    separator #7d7d7d
    background #141414
    statusline #00b0ef
    focused_workspace #00b0ef #141414 #00b0ef
    active_workspace #141414 #141414 #00b0ef
    inactive_workspace #141414 #141414 #7d7d7d
    urgent_workspace #ff7066 #141414 #ff7066
  }
}

hide_edge_borders smart

for_window [class="^.*"] border pixel 1
for_window [class="Kalu"] floating enable
for_window [class="sxiv"] floating enable
for_window [window_role="pop-up"] floating enable
for_window [window_role="task_dialog"] floating enable
for_window [window_role="Preferences$"] floating enable
for_window [floating] border pixel 1

# Gaps
gaps inner 8
gaps outer -2
smart_borders no_gaps


## Multimedia Keys

# volume
bindsym XF86AudioRaiseVolume exec --no-startup-id volume 5dB+ unmute  #increase sound volume
bindsym XF86AudioLowerVolume exec --no-startup-id volume 5dB- unmute #lower sound volume


# granular volume control
bindsym Shift+XF86AudioRaiseVolume exec --no-startup-id volume 2dB+ unmute
bindsym Shift+XF86AudioLowerVolume exec --no-startup-id volume 2dB- unmute

# mute
bindsym XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle && pkill -RTMIN+10 i3blocks #mute sound volume

bindsym XF86AudioPlay exec mocp --toggle-pause
bindsym XF86AudioPause exec mocp --toggle-pause
bindsym XF86AudioStop exec mocp --togle-pause
bindsym XF86AudioNext exec mocp --next
bindsym XF86AudioPrev exec mocp --previous

bindsym $mod+F5 exec mocp --toggle-pause
bindsym $mod+F6 exec mocp --stop
bindsym $mod+F7 exec mocp --previous
bindsym $mod+F8 exec mocp --next

# Screen brightness controls
bindsym XF86MonBrightnessUp exec xbacklight -inc 5 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 5 # decrease screen brightness

bindsym shift+XF86MonBrightnessUp exec xbacklight -inc 1 # increase screen brightness
bindsym shift+XF86MonBrightnessDown exec xbacklight -dec 1 # decrease screen brightness

# App shortcuts
bindsym $mod+w exec "/usr/bin/firefox"
bindsym $mod+n exec termite -e ranger
bindcode $mod+49 exec "networkmanager_dmenu"
bindsym --release $mod+z exec "scrot -s ~/screenshots/%b%d_%H%M%S.png"

# Redirect sound to headphones
bindsym $mod+m exec "/usr/local/bin/switch-audio-port"

# Autostart apps
exec --no-startup-id "clipit"
exec --no-startup-id unclutter
exec --no-startup-id compton --backend glx --glx-no-stencil --xrender-sync-fence --blur-background -i 0.9 -f -D 3 --inactive-dim 0.2
exec_always --no-startup-id feh --bg-scale ~/wallpaper.jpg
exec --no-startup-id "sleep 5s && dunst -config ~/.config/dunst"

client.focused #00b0ef #00b0ef #141414 #ff7066
client.focused_inactive #141414 #141414 #00b0ef #472b2a
client.unfocused #141414 #141414 #7d7d7d #141414
client.urgent #ff7066 #ff7066 #141414 #ff7066
