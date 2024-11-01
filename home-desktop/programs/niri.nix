{
  root,
  config,
  lib,
  pkgs,
}:
{
  settings = {

    outputs = {
      "DP-1".scale = 3.0;
    };

    layout = {
      gaps = 1;
      focus-ring = {
        active.color = "#83b6af";
        width = 0.3;
      };
    };

    environment = {
      # Hide QT's(telegram) title bar.
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

      # xwayland-satellite
      DISPLAY = ":0";
    };

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
      { command = [ "alacritty" ]; }
      { command = [ (lib.getExe pkgs.xwayland-satellite-unstable) ]; }
    ];

    # create 1-4 for startup apps
    workspaces = lib.genAttrs (map toString (lib.range 1 4)) (n: { });

    # input.focus-follows-mouse.enable = true;

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
        "Mod+O".action = spawn (lib.getExe pkgs.fuzzel);
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

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+Shift+A".action = spawn (lib.getExe macshot);
        "Mod+Shift+U".action = spawn (lib.getExe pkgs.pamixer) "-i" "5";
        "Mod+Shift+D".action = spawn (lib.getExe pkgs.pamixer) "-d" "5";
        "Mod+Shift+E".action = spawn (lib.getExe powermenu);
        "Mod+Shift+S".action = screenshot;
        "Mod+Shift+R".action = spawn (lib.getExe recorder-toggle);
        "Mod+Apostrophe".action = spawn (lib.getExe swaylock);
        "Mod+Shift+M".action =
          let
            jq = lib.getExe pkgs.jq;
            niri = lib.getExe pkgs.niri-unstable;
          in
          spawn (
            lib.getExe (
              pkgs.writeShellScriptBin "scale-switcher" ''
                current_scale=$(${niri} msg -j outputs | ${jq} -r '."DP-1"."logical"."scale"')
                if test "$current_scale" = "1.0"; then
                  niri msg output DP-1 scale 3.0
                else
                  niri msg output DP-1 scale 1.0
                fi
              ''
            )
          );
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
