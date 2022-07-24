{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.ocfox.wayland.windowManager.sway = {
    enable = true;

    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      startup = [
        {command = "fcitx5 -d";}
      ];
      gaps = {
        top = 0;
        inner = 5;
        outer = 5;
        smartGaps = false;
      };
      bars = [];

      workspaceOutputAssign = [
        {
          output = "HDMI-A-1";
          workspace = "9";
        }
      ];

      output = {
        DP-1 = {
          bg = "~/Pictures/Wallpapers/rurudo.jpg fill";
          mode = "2560x1440";
          scale = "2";
        };
        HDMI-A-1 = {
          bg = "~/Pictures/Wallpapers/rurudo-purple.jpg fill";
          mode = "1920x1080";
          scale = "1.5";
          transform = "180";
        };
      };

      keybindings = let
        modifier = config.home-manager.users.ocfox.wayland.windowManager.sway.config.modifier;
      in
        pkgs.lib.mkOptionDefault {
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+shift+u" = "exec pamixer -i 10";
          "${modifier}+shift+d" = "exec pamixer -d 10";
          "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
          "${modifier}+o" = "exec ${pkgs.bemenu}/bin/bemenu-run -c -l 15 -W 0.3";
          "${modifier}+space" = null;
          "${modifier}+shift+s" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" $HOME/Pictures/screenshot-$(date +\"%Y-%m-%d-%H-%M-%S\").png";
        };
    };
  };
}
