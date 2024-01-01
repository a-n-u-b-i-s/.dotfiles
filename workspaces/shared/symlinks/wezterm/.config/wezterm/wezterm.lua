local wezterm = require("wezterm")
local tabbar = require("tabbar")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

tabbar.apply_to_config(config)

config.font = wezterm.font({ family = "Berkeley Mono Variable", harfbuzz_features = { "calt=0", "clig=0", "liga=0" } })
config.font_size = 14.0
-- config.font_shaper = "Harfbuzz"
config.line_height = 1.0
config.color_scheme = "tokyonight_night"
config.colors = {
	tab_bar = {
		background = "#1f2335",
	},
}
config.check_for_updates = false
config.term = "wezterm"
config.scrollback_lines = 999999
config.hyperlink_rules = {}
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false
config.selection_word_boundary = " \t\n{}[]()\"'`"
config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.4cell",
	bottom = "0",
}
config.term = "xterm-256color"
config.default_cursor_style = "SteadyBar"
config.keys = {
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ClearScrollback("ScrollbackAndViewport"),
	},
}
config.window_background_opacity = 0.95
config.macos_window_background_blur = 10
config.hide_tab_bar_if_only_one_tab = true
return config
