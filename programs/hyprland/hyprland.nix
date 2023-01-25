{ pkgs, ... }:
''
  monitor=HDMI-A-1,preferred,auto,2

  exec-once = telegram-desktop & firefox & thunderbird & fcitx -d

  input {
      kb_layout = us
      kb_variant =
      kb_model =
      kb_options =
      kb_rules =

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

  bind = $mod, Return, exec, ${pkgs.kitty}/bin/kitty
  bind = $mod SHIFT, Q, killactive, 
  bind = $mod, space, togglefloating, 
  bind = $mod, f, fullscreen, 
  bind = $mod SHIFT, f, fakefullscreen, 
  bind = $mod, O, exec, ${pkgs.bemenu}/bin/bemenu-run -c -l 15 -W 0.3
  bind = $mod, P, pseudo,
  bind = $mod, e, togglesplit,
  bind = $mod SHIFT, s, exec, ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area

  bind = $mod, h, movefocus, l
  bind = $mod, l, movefocus, r
  bind = $mod, j, movefocus, d
  bind = $mod, k, movefocus, u

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
''
