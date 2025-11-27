{
  flake.modules.nixos.waybar =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      waybarSettings = [
        {
          layer = "top";
          position = "bottom";
          "modules-left" = [ "sway/workspaces" ];
          "modules-center" = [ "clock" ];
          "modules-right" = [
            "tray"
            "idle_inhibitor"
            "pulseaudio"
            "memory"
            "cpu"
            "network"
          ];
          "sway/workspaces" = {
            "disable-scroll" = true;
            format = "{icon}";
            "all-outputs" = true;
            "format-icons" = {
              "1" = "一";
              "2" = "二";
              "3" = "三";
              "4" = "四";
              "5" = "五";
              "6" = "六";
              "7" = "七";
              "8" = "八";
              "9" = "九";
              "10" = "十";
            };
          };
          idle_inhibitor = {
            format = "{icon}";
            "format-icons" = {
              "activated" = "IDLE";
              "deactivated" = "<s>IDLE</s>";
            };
            tooltip = false;
          };
          pulseaudio = {
            format = "Vol {volume}%";
            "format-muted" = "󰝟 Muted";
            "max-volume" = 200;
            "format-icons".default = [
              ""
              ""
              ""
            ];
            states.warning = 85;
            "scroll-step" = 1;
            "on-click" = "${lib.getExe pkgs.pwvucontrol}";
            tooltip = false;
          };
          clock = {
            interval = 1;
            format = "{:L%m月%d日(%a) %H時%M分}";
            tooltip = true;
            locale = "ja_JP.UTF-8";
            calendar = {
              format.today = "<span color='#ff6699'><b>{}</b></span>";
            };
            "tooltip-format" = "<span>{calendar}</span>";
          };
          battery = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            "format-full" = "{icon} {capacity}%";
            "format-charging" = "󰂄 {capacity}%";
            "format-plugged" = " {capacity}%";
            "format-alt" = "{icon} {time}";
            "format-icons" = [
              ""
              ""
              ""
              ""
              ""
            ];
          };
          cpu = {
            interval = 1;
            format = "CPU {usage}%";
          };
          memory = {
            interval = 5;
            format = "{used}/{total}";
          };
          network = {
            interval = 1;
            "format-wifi" = "󰖩 {essid}";
            "format-ethernet" = "{ipaddr}";
            "format-linked" = "󰖩 {essid}";
            "format-disconnected" = "󰖩 Disconnected";
            tooltip = true;
          };
          tray = {
            "icon-size" = 14;
            spacing = 5;
          };
        }
      ];
    in
    {
      my.packages = [
        pkgs.waybar
        pkgs.pwvucontrol
      ];

      # systemd.user.services.waybar = {
      #   description = "Waybar";
      #   wantedBy = [ "sway-session.target" ];
      #   partOf = [ "sway-session.target" ];
      #   serviceConfig = {
      #     Type = "simple";
      #     ExecStart = "${pkgs.waybar}/bin/waybar";
      #     ExecReload = "${pkgs.procps}/bin/kill -SIGUSR2 $MAINPID";
      #     Restart = "on-failure";
      #     RestartSec = 1;
      #   };
      # };

      my.config.waybar = {
        "config" = pkgs.writeText "waybar-config.json" (builtins.toJSON waybarSettings);
        "style.css" = ./waybar.css;
      };
    };
}
