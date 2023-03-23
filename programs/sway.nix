{ config
, pkgs
, ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway-unwrapped;

    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      startup = [
        { command = "fcitx5 -d"; }
        { command = "firefox"; }
        { command = "telegram-desktop"; }
        { command = "thunderbird"; }
      ];

      bars = [ ];

      workspaceOutputAssign = [
        {
          output = "HDMI-A-1";
          workspace = "9";
        }
      ];

      assigns = {
        "1" = [{ app_id = "firefox"; }];
        "4" = [{ app_id = "org.telegram.desktop"; }];
        "5" = [{ app_id = "thunderbird"; }];
      };

      output = {
        DP-1 = {
          bg = "~/Pictures/Wallpapers/rurudo.jpg fill";
          mode = "2560x1440";
          position = "0 0";
          scale = "2";
        };
        HDMI-A-1 = {
          bg = "~/Pictures/Wallpapers/nixos.png fill";
          mode = "1920x1080";
          scale = "2";
          transform = "180";
        };
      };

      window.hideEdgeBorders = "smart";

      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
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
          "${modifier}+space" = "floating toggle";
          "${modifier}+Shift+space" = null;
          "${modifier}+Shift+s" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
          "${modifier}+Shift+r" = "exec screen-recorder-toggle";
          # while using full screen xwayland
          "${modifier}+Shift+m" =
            let
              test = pkgs.writeShellScript "scale toggle" ''
                #!/usr/bin/env bash
                output=`${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r '.nodes[] | select([recurse(.nodes[]?, .floating_nodes[]?) | .focused] | any) | .name'`
                scale=`${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r '.nodes[] | select([recurse(.nodes[]?, .floating_nodes[]?) | .focused] | any) | .scale'`

                if [ $scale != 1 ]
                then
                  ${pkgs.sway}/bin/swaymsg output $output scale 1
                else
                  ${pkgs.sway}/bin/swaymsg output $output scale ${config.wayland.windowManager.sway.config.output.DP-1.scale}
                fi
              '';
            in
            "exec ${test}";
        };
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
    };
  };
}
