-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- config.window_background_opacity = 1.0

config.color_scheme = "Kanagawa (Gogh)"
config.colors = {
	background = "#000000",
}

config.font = wezterm.font("JetBrainsMono Nerd Font")

config.enable_tab_bar = false

-- and finally, return the configuration to wezterm
return config
