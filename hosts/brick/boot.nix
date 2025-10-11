{ pkgs }:
{
  # kernelPackages = pkgs.linuxPackages_cachyos;
  loader = {
    timeout = 30;
    # grub = {
    #   enable = true;
    #   device = "nodev";
    #   useOSProber = true;
    #   efiSupport = true;
    # };
    limine = {
      enable = true;
      style.wallpapers = [ pkgs.nixos-artwork.wallpapers.simple-dark-gray-bootloader.gnomeFilePath ];
    };
    efi.canTouchEfiVariables = true;
  };
}
