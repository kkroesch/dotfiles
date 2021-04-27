local wezterm = require 'wezterm';

return {
    font = wezterm.font("Hack Nerd Font"),
    color_scheme = "Solarized Dark - Patched",
    default_prog = {"wsl.exe"},
    default_cwd = "/Users/kkr/Projects",
    launch_menu = {
        {
          label = "WSL ZSH",
          -- The argument array to spawn.  If omitted the default program
          -- will be used as described in the documentation above
          args = {"wsl", ""},
        },
    }
}
