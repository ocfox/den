{
  flake.modules.homeManager.terminal =
    { pkgs, ... }:
    {
      programs.foot = {
        enable = true;
        settings = {
          main = {
            term = "xterm-256color";
            font = "JetBrainsMono Nerd Font:size=16";
            dpi-aware = "yes";
          };
          mouse = {
            hide-when-typing = "yes";
          };

          colors = {
            background = "2b3339";
            foreground = "d8caac";
          };
        };
      };
    };
}
