{ pkgs }:
{
  network = {
    enable = true;
    wait-online.anyInterface = true;
    networks."enp14s0" = {
      name = "enp14s0";
      networkConfig.DHCP = "yes";
    };
  };
}
