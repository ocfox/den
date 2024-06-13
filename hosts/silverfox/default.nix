# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }:

{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };

  boot.loader.efi.canTouchEfiVariables = false;


  networking.hostName = "silverfox";
  networking.networkmanager.enable = true;

  services.resolved.enable = true;

  time.timeZone = "Asia/Shanghai";

  boot.kernelParams = [ "hid_apple.fnmode=2" ];

  systemd.oomd.enableRootSlice = true;
  systemd.oomd.enableUserSlices = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-configtool
      ];
    };
  };

  zramSwap.enable = true;

  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "24.05";

  environment.systemPackages = with pkgs; [
    file
    patchelf
    btop

    firefox
  ];

  hardware.bluetooth.enable = true;
  virtualisation.podman.enable = true;
}
