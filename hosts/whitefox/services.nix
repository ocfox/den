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
    
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE:="0666", SYMLINK+="stlinkv2_%n"
  '';
  pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  yubikey-agent.enable = true;
}
