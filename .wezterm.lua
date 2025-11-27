local wezterm = require 'wezterm'
local config = {}
config.keys = {
  {
    key = 'n',
    mods = 'SHIFT|CTRL',
    action = wezterm.action.ToggleFullScreen,
  },
}
config.color_scheme_dirs = { os.getenv("HOME") .. "/.config/wezterm/colors" }
config.color_scheme = "Dracula (Official)"
config.font = wezterm.font 'JetBrains Mono'
return config