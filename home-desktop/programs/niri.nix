{
  root,
  config,
  lib,
  pkgs,
}:
{
  settings = {

    outputs = {
      "DP-1".scale = 3;
    };

    layout = {
      gaps = 1;
      focus-ring = {
        active.color = "#83b6af";
        width = 0.3;
      };
    };

    # Hide QT's(telegram) title bar.
    environment.QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    prefer-no-csd = true;

    spawn-at-startup = [
      {
        command = [
          (lib.getExe pkgs.swaybg)
          "-i"
          "${root.pkgs.wallpapers.takamaki}"
        ];
      }
      { command = [ "firefox" ]; }
      { command = [ "telegram-desktop" ]; }
      { command = [ "thunderbird" ]; }
    ];

    workspaces = lib.genAttrs (map toString (lib.range 1 9)) (n: { });

    input.focus-follows-mouse.enable = true;

    window-rules =
      let
        assign = id: workspace: {
          matches = [
            {
              app-id = id;
              at-startup = true;
            }
          ];
          open-on-workspace = workspace;
        };
      in
      [
        (assign "firefox" "1")
        (assign "Alacritty" "2")
        (assign "org.telegram.desktop" "3")
        (assign "thunderbird" "4")
      ];

    binds =
      let
        inherit (root.pkgs)
          macshot
          powermenu
          recorder-toggle
          swaylock
          ;
      in
      with config.lib.niri.actions;
      {
        "Mod+Return".action = spawn (lib.getExe pkgs.alacritty);
        "Mod+O".action = spawn (lib.getExe pkgs.kickoff);
        "Mod+H".action = focus-column-left-or-last;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right-or-first;

        "Mod+Shift+H".action = move-column-left;
        "Mod+Shift+J".action = move-window-down;
        "Mod+Shift+K".action = move-window-up;
        "Mod+Shift+L".action = move-column-right;

        "Mod+Shift+Q".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;

        "Mod+Shift+A".action = spawn (lib.getExe macshot);
        "Mod+Shift+U".action = spawn (lib.getExe pkgs.pamixer) "-i" "5";
        "Mod+Shift+D".action = spawn (lib.getExe pkgs.pamixer) "-d" "5";
        "Mod+Shift+E".action = spawn (lib.getExe powermenu);
        "Mod+Shift+S".action = spawn (lib.getExe pkgs.sway-contrib.grimshot) "copy" "area";
        "Mod+Shift+R".action = spawn (lib.getExe recorder-toggle);
        "Mod+Apostrophe".action = spawn (lib.getExe swaylock);
      }
      // lib.foldl' (
        attr: i:
        attr
        // {
          "Mod+${toString i}".action.focus-workspace = i;
          "Mod+Shift+${toString i}".action.move-window-to-workspace = i;
        }
      ) { } (lib.range 1 9);
  };
}