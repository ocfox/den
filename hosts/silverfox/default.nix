{ inputs, username, pkgs, ... }:

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

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    hashedPassword = "$6$jVI2tdENaEqUyZGh$rni.joO5US9t9RYM9wlIvia4L1YOObs44Kt3gBcooBJTeSFGyEorciM2CrKMEnzbojpi1KgPPe256i5Q46N1d0";
  };

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

  hardware.bluetooth.enable = true;
  virtualisation.podman.enable = true;
}
