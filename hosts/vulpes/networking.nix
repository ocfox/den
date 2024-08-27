{
  hostName = "vulpes";
  firewall.allowedTCPPorts = [
    80
    443
  ];
  firewall.allowedUDPPorts = [
    443
    22222
  ];
  firewall.enable = false;

  useDHCP = true;
  useNetworkd = true;
}
