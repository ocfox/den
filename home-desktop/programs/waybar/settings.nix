{ pkgs
, root
, lib
}:
let
  inherit (root.pkgs) player-metadata;
  brightnessctl = lib.getExe pkgs.brightnessctl;
in
[
  {
    "layer" = "top";
    "position" = "top";
    "modules-left" = [
      "sway/workspaces"
      "custom/music"
    ];
    "modules-center" = [
      "sway/window"
    ];
    "modules-right" = [
      "tray"
      "idle_inhibitor"
      "pulseaudio"
      "backlight"
      "cpu"
      "network"
      "battery"
      "clock"
    ];
    "sway/workspaces" = {
      "disable-scroll" = true;
      "format" = "{icon}";
      "all-outputs" = true;
      "format-icons" = {
        "1" = "<span color=\"#FF7139\"></span>";
        "2" = "<span color=\"#019733\"></span>";
        "3" = "<span color=\"#757575\"></span>";
        "4" = "<span color=\"#26A5E4\"></span>";
        "5" = "<span color=\"#0A84FF\"></span>";
        "6" = "<span color=\"#a738fd\"></span>";
        "7" = "<span color=\"#019733\">7</span>";
        "8" = "<span color=\"#757575\">8</span>";
        "9" = "<span color=\"#26A5E4\">9</span>";
      };
    };
    "idle_inhibitor" = {
      "format" = "{icon}";
      "format-icons" = {
        "activated" = "󰈈";
        "deactivated" = "󰈉";
      };
      "tooltip" = false;
    };
    "backlight" = {
      "device" = "apple-panel-bl";
      "on-scroll-up" = "${brightnessctl} s 1%-";
      "on-scroll-down" = "${brightnessctl} s +1%";
      "format" = "{icon} {percent}%";
      "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
    };
    "pulseaudio" = {
      "format" = "{icon} {volume}%";
      "format-muted" = "󰝟 Muted";
      "max-volume" = 200;
      "format-icons" = {
        "default" = [ "" "" "" ];
      };
      "states" = {
        "warning" = 85;
      };
      "scroll-step" = 1;
      "on-click" = "${lib.getExe pkgs.pavucontrol}";
      "tooltip" = false;
    };
    "clock" = {
      "interval" = 1;
      "format" = "{:%H:%M %b %d}";
      "tooltip" = true;
      "today-format" = "<span color='#ff6699'><b>{}</b></span>";
      "tooltip-format" = "{:%A %B %Y}\n<tt>{calendar}</tt>";
    };
    "battery" = {
      "states" = {
        "warning" = 30;
        "critical" = 15;
      };
      "format" = "{icon} {capacity}%";
      "format-full" = "{icon} {capacity}%";
      "format-charging" = "󰂄 {capacity}%";
      "format-plugged" = " {capacity}%";
      "format-alt" = "{icon} {time}";
      "format-icons" = [ "" "" "" "" "" ];
    };
    "cpu" = {
      "interval" = 1;
      "format" = "󰘚 {usage}%";
    };
    "custom/music" = {
      "format" = "{}";
      "interval" = 1;
      "exec-if" = "${lib.getExe pkgs.playerctl} metadata";
      "exec" = "${player-metadata}";
    };
    "network" = {
      "interval" = 1;
      "format-wifi" = "󰖩 {essid}";
      "format-ethernet" = "󰈀 {ipaddr}";
      "format-linked" = "󰖩 {essid}";
      "format-disconnected" = "󰖩 Disconnected";
      "tooltip" = false;
    };
    "tray" = {
      "icon-size" = 14;
      "spacing" = 5;
    };
  }
]
