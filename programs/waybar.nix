{pkgs}: {
  "layer" = "top";
  "output" = "DP-1";
  "position" = "top";
  "modules-right" = ["bluetooth" "network" "pulseaudio" "tray"];
  "modules-center" = ["sway/workspaces" "sway/mode"];
  "modules-left" = ["clock" "cpu" "temperature" "custom/music" "custom/recorder"];
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
  "bluetooth" = {
    "format" = "bluetooth:{status}";
    "format-connected" = "{device_alias}";
    "on-click" = "${pkgs.blueman}/bin/blueman-manager";
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
    "format" = "{:%H:%M %b %e}";
    "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    "today-format" = "<b>{}</b>";
  };
  "cpu" = {
    "interval" = "5";
    "format" = "{max_frequency}GHz <span color=\"darkgray\">{usage}%</span>";
    "on-click" = "${pkgs.kitty}/bin/kitty -e ${pkgs.htop}/bin/htop --sort-key PERCENT_CPU";
    "tooltip" = false;
  };
  "temperature" = {
    "interval" = "5";
    "hwmon-path" = "/sys/class/hwmon/hwmon3/temp1_input";
    "critical-threshold" = 74;
    "format-critical" = " {temperatureC}°C";
    "format" = "{temperatureC}°C";
  };
  "network" = {
    "format-wifi" = "wifi:{essid}";
    "format-ethernet" = "{ifname}: {ipaddr}/{cidr}";
    "format-linked" = "{ifname} (No IP)";
    "format-disconnected" = "disconnect";
    "format-alt" = "{ifname}: {ipaddr}/{cidr}";
    "family" = "ipv4";
    "tooltip-format-wifi" = " {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\n{bandwidthUpBits} {bandwidthDownBits}";
    "tooltip-format-ethernet" = " {ifname}\nIP: {ipaddr}\n{bandwidthUpBits} {bandwidthDownBits}";
  };
  "pulseaudio" = {
    "scroll-step" = 3;
    "format" = "{volume}%";
    "format-muted" = "muted";
    "on-click" = pkgs.writeShellScript "mute-toggle" ''
      #!/usr/bin/env bash
      if [[ $(${pkgs.pamixer}/bin/pamixer --get-volume-human) == "muted" ]]
      then
        ${pkgs.pamixer}/bin/pamixer -u
      else
        ${pkgs.pamixer}/bin/pamixer -m
      fi
    '';
  };
  "custom/weather" = {
    "exec" = "curl 'https://wttr.in/?format=1'";
    "interval" = 3600;
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
  "custom/recorder" = {
    "interval" = 1;
    "exec" = pkgs.writeShellScript "record-status" ''
      #!/usr/bin/env bash
      pid=`${pkgs.procps}/bin/pgrep wf-recorder`
      status=$?

      if [ $status != 0 ]
      then
        echo '';
      else
        echo '';
      fi;
    '';
    "on-click" = pkgs.writeShellScript "recorder-toggle" ''
      #!/usr/bin/env bash
      pid=`${pkgs.procps}/bin/pgrep wf-recorder`
      status=$?

      if [ $status != 0 ]
      then
        ${pkgs.mpv}/bin/mpv $HOME/Videos/record/$(${pkgs.coreutils-full}/bin/ls -rt $HOME/Videos/record | ${pkgs.coreutils-full}/bin/tail -n 1)
      else
        ${pkgs.procps}/bin/pkill --signal SIGINT wf-recorder
      fi;
    '';
  };
}
