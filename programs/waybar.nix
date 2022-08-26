{pkgs}:
{
  "layer" = "top";
  "output" = "DP-1";
  "position" = "top";
  "modules-left" = [
    "sway/workspaces"
    "temperature"
    "idle_inhibitor"
    "custom/music"
  ];
  "modules-center" = [
    "clock"
  ];
  "modules-right" = [
    "pulseaudio"
    "backlight"
    "memory"
    "cpu"
    "network"
    "tray"
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
      "5" = "<span color=\"#0A84FF\"></span>";
      "6" = "<span color=\"#a738fd\"></span>";
      "7" = "<span color=\"#019733\">7</span>";
      "8" = "<span color=\"#757575\">8</span>";
      "9" = "<span color=\"#26A5E4\"></span>";
      "focused" = "";
      "default" = "";
    };
  };
  "idle_inhibitor" = {
    "format" = "{icon}";
    "format-icons" = {
      "activated" = "";
      "deactivated" = "";
    };
    "tooltip" = false;
  };
  "backlight" = {
    "device" = "intel_backlight";
    "on-scroll-up" = "light -A 5";
    "on-scroll-down" = "light -U 5";
    "format" = "{icon} {percent}%";
    "format-icons" = ["" "" "" ""];
  };
  "pulseaudio" = {
    "format" = "{icon} {volume}%"; 
    "format-muted" = "婢 Muted";
    "format-icons" = {
      "default" = ["" "" ""];
    };
    "states" = {
      "warning" = 85;
    };
    "scroll-step" = 1;
    "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
    "tooltip" = false;
  };
  "clock" = {
    "interval" = 1;
    "format" = "{:%I:%M %p  %A %b %d}";
    "tooltip" = false;
    "tooltip-format" = "{:%A; %d %B %Y}\n<tt>{calendar}</tt>";
  };
  "memory" = {
    "interval" = 1;
    "format" = "﬙ {percentage}%";
    "states" = {
      "warning" = 85;
    };
  };
  "cpu" = {
    "interval" = 1;
    "format" = " {usage}%";
  };
  "custom/music" = {
    "format" = "{}";
    "interval" = 1;
    "exec-if" = "${pkgs.playerctl}/bin/playerctl metadata";
    # "exec" = "echo $(${pkgs.playerctl}/bin/playerctl metadata artist) - $(${pkgs.playerctl}/bin/playerctl metadata title)";
    "exec" = pkgs.writeShellScript "music" ''
      #!/usr/bin/env bash
      if [[ $(${pkgs.playerctl}/bin/playerctl metadata artist) ]]
      then
        echo $(${pkgs.playerctl}/bin/playerctl metadata artist) - $(${pkgs.playerctl}/bin/playerctl metadata title)
      else
        echo $(${pkgs.playerctl}/bin/playerctl metadata title)
      fi
    '';
  };
  "network" = {
    "interval" = 1;
    "format-wifi" = "說 {essid}";
    "format-ethernet" = "  {ifname} ({ipaddr})";
    "format-linked" = "說 {essid} (No IP)";
    "format-disconnected" = "說 Disconnected";
    "tooltip" = false;
  };
  "temperature" = {
    "hwmon-path" = "/sys/class/hwmon/hwmon6/temp2_input";
    "tooltip" = false;
    "format" = " {temperatureC}°C";
  };
  "tray" = {
    "icon-size" = 15;
    "spacing" = 5;
  };
}
