{ pkgs }:
{
  # network = {
  #   enable = true;
  #   # wait-online.anyInterface = true;

  #   networks = {
  #     "21-virtualization-interfaces".extraConfig = ''
  #       [Match]
  #       Name=docker* virbr* lxdbr* veth* vboxnet*

  #       [Link]
  #       Unmanaged=yes
  #     '';

  #     "enp14s0" = {
  #       name = "enp14s0";
  #       networkConfig.DHCP = "yes";
  #     };
  #   };
  # };
}
