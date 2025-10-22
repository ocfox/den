{ config, ... }:
let
  inherit (config.flake.modules.homeManager)
    waybar
    gtk
    mako
    ;
in
{
  flake.modules.homeManager.sway =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        waybar
        mako
        gtk
      ];
      home.packages = with pkgs; [
        wl-clipboard
        firefox
        tdesktop
        thunderbird
      ];
      programs.fuzzel = {
        enable = true;
        settings = {
          border.radius = 0;
        };
      };
      # Auto startup Sway
      programs.fish.interactiveShellInit = ''
        if test (id --user $USER) = 1000 && test (tty) = "/dev/tty1"
          exec sway
        end
      '';

      wayland.windowManager.sway = {
        enable = true;
        systemd.enable = true;

        wrapperFeatures.gtk = true;
        config = {
          modifier = "Mod4";
          startup = [
            { command = "fcitx5 -d"; }
            { command = "firefox"; }
            { command = "Telegram"; }
            { command = "thunderbird"; }
          ];

          floating.criteria = [
            {
              title = "Feishu Meetings";
            }
          ];

          bars = [ ];

          assigns = {
            "1" = [ { app_id = "firefox"; } ];
            "3" = [ { app_id = "org.telegram.desktop"; } ];
            "4" = [ { app_id = "thunderbird"; } ];
          };

          output =
            let
              oshino = pkgs.fetchurl {
                url = "https://pb.ocfox.me/oshino";
                name = "oshino.jpg";
                hash = "sha256-gy+LJsN0tulKG8iKsbrRAU2SAeb2VgRkQ3A/JPyigsg=";
              };
            in
            {
              HDMI-A-2 = {
                mode = "3840x2160";
                position = "0 0";
                scale = "3";
                bg = "${oshino} fill";
              };

              HDMI-A-1 = {
                mode = "3840x2160";
                scale = "3";
                bg = "${oshino} fill";
              };
            };

          defaultWorkspace = "1";

          window = {
            titlebar = false;
            hideEdgeBorders = "smart";
          };

          workspaceOutputAssign = [
            {
              output = "HDMI-A-1";
              workspace = "10";
            }
          ];

          keybindings =
            let
              modifier = config.wayland.windowManager.sway.config.modifier;
              inherit (pkgs.local)
                macshot
                powermenu
                recorder-toggle
                monitor-toggle
                swaylock
                ;
            in
            pkgs.lib.mkOptionDefault {
              "${modifier}+h" = "focus left";
              "${modifier}+j" = "focus down";
              "${modifier}+k" = "focus up";
              "${modifier}+l" = "focus right";
              "${modifier}+apostrophe" = "exec ${lib.getExe swaylock}";
              "${modifier}+d" = "move scratchpad";
              "${modifier}+i" = "scratchpad show";
              "${modifier}+Shift+a" = "exec ${lib.getExe macshot}";
              "${modifier}+Shift+u" =
                "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%+";
              "${modifier}+Shift+d" =
                "exec ${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 5%-";
              "${modifier}+Shift+e" = "exec ${lib.getExe powermenu}";
              "${modifier}+Return" = "exec ${lib.getExe pkgs.foot}";
              "${modifier}+o" = "exec ${lib.getExe pkgs.fuzzel}";
              "${modifier}+space" = "floating toggle";
              "${modifier}+Shift+space" = null;
              "${modifier}+Shift+s" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
              "${modifier}+Shift+p" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy output";
              "${modifier}+Shift+r" = "exec ${lib.getExe recorder-toggle}";
              "${modifier}+Shift+m" = "exec ${lib.getExe monitor-toggle}";
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

        extraConfig = ''
          titlebar_border_thickness 0
          titlebar_padding 1
        '';
      };
    };
}
