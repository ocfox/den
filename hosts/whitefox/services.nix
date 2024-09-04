{ username, pkgs }:
{
  pcscd.enable = true;
  getty.autologinUser = username;
  devmon.enable = true;

  home-assistant = {
    enable = true;
    customLovelaceModules = with pkgs.home-assistant-custom-lovelace-modules; [
      mini-graph-card
    ];

    lovelaceConfig = {
      title = "My Awesome Home";
      views = [
        {
          title = "Ele";
          cards = [
            {
              type = "custom:mini-graph-card";
              entities = [
                {
                  entity = "sensor.last_electricity_usage";
                  name = "每日用电量";
                  aggregate_func = "first";
                  show_state = true;
                  show_points = true;
                }
              ];
              group_by = "date";
              hour24 = true;
              hours_to_show = 240;
            }
          ];
        }
      ];
    };
    config = {
      default_config = { };
    };
  };

  tailscale.enable = true;

  blueman.enable = true;
  openssh.enable = true;
  udev.packages = [ pkgs.android-udev-rules ];

  udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE:="0666", SYMLINK+="stlinkv2_%n"
  '';

  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
