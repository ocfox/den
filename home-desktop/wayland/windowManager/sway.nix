{
  config,
  lib,
  root,
  pkgs,
}:
{
  enable = false;

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

    assigns = {
      "1" = [ { app_id = "firefox"; } ];
      "4" = [ { app_id = "org.telegram.desktop"; } ];
      "5" = [ { app_id = "thunderbird"; } ];
    };

    output =

      let
        inherit (root.pkgs.wallpapers) takamaki;
      in
      {
        DP-1 = {
          mode = "3840x2160";
          position = "640 0";
          scale = "3";
          bg = "${takamaki} fill";
        };

        HDMI-A-3 = {
          mode = "1920x1080";
          position = "0 0";
          scale = "3";
          bg = "${takamaki} fill";
        };
      };

    defaultWorkspace = "1";

    window = {
      titlebar = false;
      hideEdgeBorders = "smart";
    };

    workspaceOutputAssign = [
      {
        output = "HDMI-A-3";
        workspace = "9";
      }
    ];

    keybindings =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
        inherit (root.pkgs)
          macshot
          powermenu
          recorder-toggle
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
        "${modifier}+Shift+u" = "exec ${lib.getExe pkgs.pamixer} -i 5";
        "${modifier}+Shift+d" = "exec ${lib.getExe pkgs.pamixer} -d 5";
        "${modifier}+Shift+e" = "exec ${lib.getExe powermenu}";
        "${modifier}+Return" = "exec ${lib.getExe pkgs.alacritty}";
        "${modifier}+o" = "exec ${lib.getExe' pkgs.kickoff "kickoff"}";
        "${modifier}+space" = "floating toggle";
        "${modifier}+Shift+space" = null;
        "${modifier}+Shift+s" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
        "${modifier}+Shift+r" = "exec ${lib.getExe recorder-toggle}";
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
}
