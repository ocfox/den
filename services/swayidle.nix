{
  pkgs,
  config,
  ...
}: {
  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = "systemctl suspend";
      }
    ];
  };
}
