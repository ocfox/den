{ lib, pkgs, username, ... }:
let
  swww = "${lib.getExe pkgs.swww}";
  swww-daemon = "${pkgs.swww}/bin/swww-daemon";
  grimshot = "${lib.getExe pkgs.sway-contrib.grimshot}";
  convert = "${pkgs.imagemagick}/bin/convert";
  mac-shot = pkgs.writeShellScriptBin "mac-shot" ''
    file=/tmp/xxx.png
    ${grimshot} --notify save area /tmp/src.png >> /dev/null 2>&1

    ${convert} /tmp/src.png \
      \( +clone -alpha extract \
      -draw 'fill black polygon 0,0 0,8 8,0 fill white circle 8,8 8,0' \
      \( +clone -flip \) -compose Multiply -composite \
      \( +clone -flop \) -compose Multiply -composite \
      \) -alpha off -compose CopyOpacity -composite /tmp/output.png

    ${convert} /tmp/output.png -bordercolor none -border 20 \( +clone -background black -shadow 80x8+15+15 \) \
      +swap -background transparent -layers merge +repage $file

    ${pkgs.wl-clipboard}/bin/wl-copy -t image/png < $file
    rm /tmp/src.png /tmp/output.png
  '';
  rurudo = pkgs.fetchurl {
    url = "https://pastb.in/rurudo.jpg";
    name = "rurudo.jpg";
    hash = "sha256-TtzQhvYAXf39DM2ZzzciRzOHhXePsVBCOPXoQCngwDs=";
  };
in
''
  monitor = HDMI-A-1, 2560x1440, 0x0, 2
  monitor = DP-1, 3840x2160, 1280x0, 3, bitdepth, 10

  exec-once = fcitx5 -d & telegram-desktop & firefox & thunderbird
  exec-once = ${swww-daemon} & sleep 3; ${swww} img -o DP-1 ${rurudo}

  input {
    kb_layout = us
    follow_mouse = 1

    touchpad {
      natural_scroll = no
    }
    sensitivity = 0
  }

  general {
    gaps_in = 2
    gaps_out = 2
    border_size = 1
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
  }

  decoration {
    # rounding = 10
    blur = yes
    blur_size = 3
    blur_passes = 1
    blur_new_optimizations = on
    inactive_opacity = 0.95

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
  }

  animations {
    enabled = yes
    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = fade, 1, 7, default
    animation = workspaces, 1, 6, default
  }

  dwindle {
    pseudotile = yes
    preserve_split = yes
    no_gaps_when_only = true
  }

  master {
    new_is_master = true
  }

  gestures {
    workspace_swipe = off
  }

  device:epic mouse V1 {
    sensitivity = -0.5
  }

  $mod = SUPER

  bind = $mod, Return, exec, ${lib.getExe pkgs.kitty}
  bind = $mod SHIFT, Q, killactive, 
  bind = $mod, space, togglefloating, 
  bind = $mod, f, fullscreen, 
  bind = $mod SHIFT, f, fakefullscreen, 
  bind = $mod, O, exec, ${pkgs.bemenu}/bin/bemenu-run -c -l 15 -W 0.3
  bind = $mod SHIFT, s, exec, ${grimshot} --notify copy area
  bind = $mod SHIFT, a, exec, ${lib.getExe mac-shot}
  bind = $mod SHIFT, u, exec, ${lib.getExe pkgs.pamixer} -i 10
  bind = $mod SHIFT, d, exec, ${lib.getExe pkgs.pamixer} -d 10
  bind = $mod SHIFT, e, exec, power-menu
  bind = $mod SHIFT, r, exec, screen-recorder-toggle

  bind = $mod, P, pseudo,
  bind = $mod, e, togglesplit
  bind = $mod, w, togglegroup

  bind = $mod, h, movefocus, l
  bind = $mod, l, movefocus, r
  bind = $mod, j, movefocus, d
  bind = $mod, k, movefocus, u

  bind = $mod SHIFT, h, movewindow, l
  bind = $mod SHIFT, l, movewindow, r
  bind = $mod SHIFT, j, movewindow, d
  bind = $mod SHIFT, k, movewindow, u

  bind = $mod, 1, workspace, 1
  bind = $mod, 2, workspace, 2
  bind = $mod, 3, workspace, 3
  bind = $mod, 4, workspace, 4
  bind = $mod, 5, workspace, 5
  bind = $mod, 6, workspace, 6
  bind = $mod, 7, workspace, 7
  bind = $mod, 8, workspace, 8
  bind = $mod, 9, workspace, 9
  bind = $mod, 0, workspace, 10

  bind = $mod SHIFT, 1, movetoworkspace, 1
  bind = $mod SHIFT, 2, movetoworkspace, 2
  bind = $mod SHIFT, 3, movetoworkspace, 3
  bind = $mod SHIFT, 4, movetoworkspace, 4
  bind = $mod SHIFT, 5, movetoworkspace, 5
  bind = $mod SHIFT, 6, movetoworkspace, 6
  bind = $mod SHIFT, 7, movetoworkspace, 7
  bind = $mod SHIFT, 8, movetoworkspace, 8
  bind = $mod SHIFT, 9, movetoworkspace, 9
  bind = $mod SHIFT, 0, movetoworkspace, 10

  bind = $mod, mouse_down, workspace, e+1
  bind = $mod, mouse_up, workspace, e-1

  bindm = $mod, mouse:272, movewindow
  bindm = $mod, mouse:273, resizewindow

  workspace = HDMI-A-1, 9

  windowrulev2 = opacity 0.97 0.97, class:org.telegram.desktop
  windowrulev2 = workspace 1, class:firefox
  windowrulev2 = workspace 4, class:org.telegram.desktop
  windowrulev2 = workspace 5, class:thunderbird
  windowrulev2 = float, class:wemeetapp

  layerrule = noanim,selection
  layerrule = blur, waybar
  layerrule = blur, notifications
''
