local wezterm = require 'wezterm';

return {
    font = wezterm.font("Hack Nerd Font"),
    color_scheme = "Solarized Dark - Patched",
    default_prog = {"wsl.exe"},
    default_cwd = "/Users/kkr/Projects",
    enable_scroll_bar = true,
    launch_menu = {
        {
          label = "WSL ZSH",
          args = {"wsl", ""},
        },
        {
          label = "Powershell",
          args = {"powershell.exe", ""},
        },
    }
}
