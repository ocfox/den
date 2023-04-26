{ username }:
{
  pcscd.enable = true;
  getty.autologinUser = username;
  devmon.enable = true;
  printing.enable = true;
  blueman.enable = true;
  openssh.enable = true;
  udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
  '';
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  tailscale.enable = true;
}
