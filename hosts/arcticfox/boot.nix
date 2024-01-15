{ pkgs }:
{
  loader.systemd-boot.enable = true;

  kernelPackages = pkgs.linuxPackages_latest;
}
