{ username, pkgs }:
{
  pcscd.enable = true;
  getty.autologinUser = username;
  devmon.enable = true;
  printing.enable = true;
  printing.drivers = [ pkgs.hplip ];

  blueman.enable = true;

  tailscale.enable = true;

  xwayland-satellite.enable = true;

  openssh.enable = true;
  udev.packages = [ pkgs.android-udev-rules ];

  udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"

    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE:="0666", SYMLINK+="stlinkv2_%n"
  '';

  gnome.sushi.enable = true;

  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
