{
  pkgs,
  username,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/cd-dvd/iso-image.nix")
    (modulesPath + "/profiles/all-hardware.nix")
  ];

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  isoImage.makeEfiBootable = true;
  isoImage.makeUsbBootable = true;

  time.timeZone = "Asia/Shanghai";

  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
    hostName = "ferrucyon";
    useDHCP = false;
  };

  programs = {
    dconf.enable = true;
    fish.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    getty.autologinUser = username;
    openssh.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    initialPassword = "0000";
    extraGroups = [ "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "23.05";
}
