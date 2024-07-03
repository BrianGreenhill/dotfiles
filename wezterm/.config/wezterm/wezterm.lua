local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Rosé Pine Moon (Gogh)"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 13.0
config.line_height = 1.4
config.window_decorations = "RESIZE"
config.enable_tab_bar = false

config.keys = {
    {
        key = "r",
        mods = "CMD|SHIFT",
        action = wezterm.action.ReloadConfiguration,
    },
}

return config
