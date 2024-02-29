{ pkgs }:
{
  loader = {
    grub = {
      minegrub-theme = {
        enable = true;
        splash = "Infinite recursion";
      };
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };
}
