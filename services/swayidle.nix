{
  pkgs,
  config,
  ...
}: {
  services.swayidle = {
    enable = true;
    timeouts = [
      # {
      #   timeout = 300;
      #   command = "${pkgs.sway}/bin/swaymsg 'output * dmps off'";
      #   resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dmps on'";
      # }
      {
        timeout = 900;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
