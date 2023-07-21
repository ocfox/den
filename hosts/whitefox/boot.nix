{ pkgs }:
{
  loader = {
    grub = {
      minegrub-theme.enable = true;
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };

  kernelPackages = pkgs.linuxPackages_latest;
}
