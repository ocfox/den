{ pkgs }:
{
  kernelPackages = pkgs.linuxPackages_cachyos;
  loader = {
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      minegrub-world-sel-theme.enable = true;
    };
    efi.canTouchEfiVariables = true;
  };
}
