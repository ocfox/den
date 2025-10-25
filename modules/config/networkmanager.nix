{
  flake.modules.nixos.networkmanager = {
    networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;
    networking.useDHCP = false;
  };
}
