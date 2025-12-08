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
              "1" = "い";
              "2" = "ろ";
              "3" = "は";
              "4" = "に";
              "5" = "ほ";
              "6" = "へ";
              "7" = "と";
              "8" = "ち";
              "9" = "り";
              "10" = "ぬ";
            };
          };
          idle_inhibitor = {
            format = "{icon}";
            "format-icons" = {
              "activated" = "<s>待</s>";
              "deactivated" = "待";
            };
            tooltip = false;
          };
          pulseaudio = {
            format = "響 {volume}%";
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
            format = "荷 {usage}%";
          };
          memory = {
            interval = 5;
            format = "憶 {used}/{total}";
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
