{pkgs}: {
  "layer" = "top";
  "position" = "top";
  "modules-right" = ["bluetooth" "network" "pulseaudio" "tray"];
  "modules-center" = ["sway/workspaces" "sway/mode"];
  "modules-left" = ["clock" "cpu" "temperature" "custom/recorder"];
  "sway/workspaces" = {
    "disable-scroll" = true;
    "all-outputs" = true;
    "format" = "{icon}";
    "format-icons" = {
      "1" = "<span color=\"#FF7139\"></span>";
      "2" = "<span color=\"#019733\"></span>";
      "3" = "<span color=\"#757575\"></span>";
      "4" = "<span color=\"#26A5E4\"></span>";
      "5" = "<span color=\"#0A84FF\"></span>";
      "urgent" = "";
      "focused" = "";
      "default" = "";
    };
  };
  "sway/mode" = {
    "format" = "<span style=\"italic\">{}</span>";
  };
  "sway/window" = {
    "format" = "{}";
    "max-length" = 50;
    "tooltip" = false;
  };
  "idle_inhibitor" = {
    "format" = "{icon}";
    "format-icons" = {
      "activated" = "";
      "deactivated" = "";
    };
    "tooltip" = "true";
  };
  "tray" = {
    "spacing" = 5;
  };
  "clock" = {
    "format" = "  {:%H:%M   %e %b}";
    "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    "today-format" = "<b>{}</b>";
    "on-click" = "gnome-calendar";
  };
  "cpu" = {
    "interval" = "1";
    "format" = "﬙  {max_frequency}GHz <span color=\"darkgray\">| {usage}%</span>";
    "max-length" = 13;
    "min-length" = 13;
    "on-click" = "kitty -e htop --sort-key PERCENT_CPU";
    "tooltip" = false;
  };
  "temperature" = {
    "interval" = "4";
    "hwmon-path" = "/sys/class/hwmon/hwmon3/temp1_input";
    "critical-threshold" = 74;
    "format-critical" = "  {temperatureC}°C";
    "format" = "{icon}  {temperatureC}°C";
    "format-icons" = ["" "" ""];
    "max-length" = 7;
    "min-length" = 7;
  };
  "network" = {
    "format-wifi" = "  {essid}";
    "format-ethernet" = "{ifname}: {ipaddr}/{cidr} ";
    "format-linked" = "{ifname} (No IP) ";
    "format-disconnected" = "";
    "format-alt" = "{ifname}: {ipaddr}/{cidr}";
    "family" = "ipv4";
    "tooltip-format-wifi" = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\n {bandwidthUpBits}  {bandwidthDownBits}";
    "tooltip-format-ethernet" = " {ifname}\nIP: {ipaddr}\n {bandwidthUpBits}  {bandwidthDownBits}";
  };
  "pulseaudio" = {
    "scroll-step" = 3;
    "format" = "{icon} {volume}% {format_source}";
    "format-bluetooth" = "{volume}% {icon} {format_source}";
    "format-bluetooth-muted" = " {icon} {format_source}";
    "format-muted" = " {format_source}";
    "format-source" = "";
    "format-source-muted" = "";
    "format-icons" = {
      "headphone" = "";
      "hands-free" = "";
      "headset" = "";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = ["" "" ""];
    };
    "on-click" = "pavucontrol";
    "on-click-right" = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
  };
  "custom/weather" = {
    "exec" = "curl 'https://wttr.in/?format=1'";
    "interval" = 3600;
  };
  "custom/recorder" = {
    "format" = "";
    "return-type" = "json";
    "interval" = 1;
    "exec" = "echo '{\"class\": \"recording\"}'";
    "exec-if" = "pgrep wf-recorder";
  };
}
