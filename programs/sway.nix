{ config
, lib
, pkgs
, ...
}: {
  home-manager.users.ocfox.wayland.windowManager.sway = {
    enable = true;

    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      startup = [
        { command = "fcitx5 -d"; }
        { command = "firefox"; }
      ];
      gaps = {
        inner = 2;
        outer = 1;
      };
      bars = [ ];

      colors = {
        focused = {
          background = "#83b6af";
          border = "#83b6af";
          childBorder = "#83b6af";
          indicator = "#a7c080";
          text = "#ffffff";
        };
        unfocused = {
          background = "#2b3339";
          border = "#2b3339";
          childBorder = "#2b3339";
          indicator = "#a7c080";
          text = "#888888";
        };
        urgent = {
          background = "#e68183";
          border = "#e68183";
          childBorder = "#e68183";
          indicator = "#a7c080";
          text = "#ffffff";
        };
      };

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
          position = "0 0";
          scale = "2";
        };
        HDMI-A-1 = {
          bg = "~/Pictures/Wallpapers/fubuki-school.jpg fill";
          mode = "1920x1080";
          scale = "2";
          transform = "90";
        };
      };

      window.hideEdgeBorders = "smart";

      keybindings =
        let
          modifier = config.home-manager.users.ocfox.wayland.windowManager.sway.config.modifier;
        in
        pkgs.lib.mkOptionDefault {
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";
          "${modifier}+d" = "move scratchpad";
          "${modifier}+i" = "scratchpad show";
          "${modifier}+Shift+u" = "exec pamixer -i 10";
          "${modifier}+Shift+d" = "exec pamixer -d 10";
          "${modifier}+Shift+e" = "exec power-menu";
          "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
          "${modifier}+o" = "exec ${pkgs.bemenu}/bin/bemenu-run -c -l 15 -W 0.3";
          "${modifier}+Shift+m" = "exec ${pkgs.sway}/bin/swaymsg output DP-1 scale 1";
          "${modifier}+m" = "exec ${pkgs.sway}/bin/swaymsg output DP-1 scale 2";
          "${modifier}+space" = "floating toggle";
          "${modifier}+Shift+space" = null;
          "${modifier}+Shift+s" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
          "${modifier}+shift+r" = "exec screen-recorder-toggle";
        };
    };
  };
}
