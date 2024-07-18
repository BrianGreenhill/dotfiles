local wezterm = require 'wezterm';

return {
    font = wezterm.font 'JetBrains Mono',
    font_size = 13.0,
    line_height = 1.1,
    hide_tab_bar_if_only_one_tab = true,
    enable_tab_bar = true,
    window_decorations = "RESIZE",
    audible_bell = "Disabled",
    harfbuzz_features = { "calt=0", "clig=0", "liga=0" },

    color_scheme = "Kanagawa Dragon",
    colors = {
        foreground = "#dcd7ba",
        background = "#1f1f28",
        cursor_bg = "#c34043",
        cursor_border = "#c34043",
        cursor_fg = "#c8c093",
        selection_bg = "#2d4f67",
        selection_fg = "#dcd7ba",

        ansi = {
            "#090618", "#c34043", "#76946a", "#c0a36e",
            "#7e9cd8", "#957fb8", "#6a9589", "#c8c093"
        },
        brights = {
            "#727169", "#e82424", "#98bb6c", "#e6c384",
            "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba"
        },

        tab_bar = {
            background = "#090618",
            active_tab = {
                bg_color = "#c34043",
                fg_color = "#dcd7ba",
            },
            inactive_tab = {
                bg_color = "#1f1f28",
                fg_color = "#c8c093",
            },
            inactive_tab_hover = {
                bg_color = "#c0a36e",
                fg_color = "#1f1f28",
            },
            new_tab = {
                bg_color = "#090618",
                fg_color = "#dcd7ba",
            },
            new_tab_hover = {
                bg_color = "#e82424",
                fg_color = "#1f1f28",
            },
        },
    },
}
