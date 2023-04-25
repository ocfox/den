{ pkgs }:
{
  loader = {
    grub2-theme = {
      enable = true;
      theme = "whitesur";
      screen = "4k";
    };
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };

  kernelPackages = pkgs.linuxPackages_latest;
}
