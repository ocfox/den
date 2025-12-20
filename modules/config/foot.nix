{
  flake.modules.nixos.foot =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      settingsFormat = pkgs.formats.ini { };

      footSettings = {
        url.launch = "foot -e xdg-open \${url}";
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono Nerd Font:size=16";
          "dpi-aware" = "yes";
        };
        mouse = {
          "hide-when-typing" = "yes";
        };
        colors = {
          background = "2b3339";
          foreground = "d8caac";
        };
      };
    in
    {
      my.packages = [ pkgs.foot ];

      my.config.foot = {
        "foot.ini" = settingsFormat.generate "foot.ini" footSettings;
      };
    };
}
