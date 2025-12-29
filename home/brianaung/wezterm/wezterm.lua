local wezterm = require "wezterm"
local config = wezterm.config_builder()

local smart_splits = wezterm.plugin.require "https://github.com/mrjones2014/smart-splits.nvim"
local workspace_switcher = wezterm.plugin.require "https://github.com/MLFlexer/smart_workspace_switcher.wezterm"

wezterm.on("update-right-status", function(window, _) window:set_right_status(window:active_workspace()) end)

config.font = wezterm.font "Terminess Nerd Font Mono"
config.font_size = 13
config.command_palette_font = wezterm.font "Terminess Nerd Font Mono"
config.command_palette_font_size = 13

config.color_scheme = "Gruvbox Material (Gogh)"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.inactive_pane_hsb = { saturation = 0.24, brightness = 0.5 }
config.skip_close_confirmation_for_processes_named = {}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  { key = "a", mods = "LEADER|CTRL", action = wezterm.action.SendKey { key = "a", mods = "CTRL" } },

  { key = "c", mods = "LEADER", action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
  { key = "-", mods = "LEADER", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "=", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "x", mods = "LEADER", action = wezterm.action { CloseCurrentPane = { confirm = true } } },
  -- { key = "s", mods = "LEADER", action = workspace_switcher.switch_workspace() },

  { key = "[", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
  { key = ":", mods = "LEADER|SHIFT", action = wezterm.action.ActivateCommandPalette },

  { key = "h", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "j", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Down" } },
  { key = "k", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Up" } },
  { key = "l", mods = "LEADER", action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "1", mods = "LEADER", action = wezterm.action { ActivateTab = 0 } },
  { key = "2", mods = "LEADER", action = wezterm.action { ActivateTab = 1 } },
  { key = "3", mods = "LEADER", action = wezterm.action { ActivateTab = 2 } },
  { key = "4", mods = "LEADER", action = wezterm.action { ActivateTab = 3 } },
  { key = "5", mods = "LEADER", action = wezterm.action { ActivateTab = 4 } },
  { key = "6", mods = "LEADER", action = wezterm.action { ActivateTab = 5 } },
  { key = "7", mods = "LEADER", action = wezterm.action { ActivateTab = 6 } },
  { key = "8", mods = "LEADER", action = wezterm.action { ActivateTab = 7 } },
  { key = "9", mods = "LEADER", action = wezterm.action { ActivateTab = 8 } },
}

smart_splits.apply_to_config(config)
workspace_switcher.apply_to_config(config)

return config
