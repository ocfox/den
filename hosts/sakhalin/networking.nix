{
  hostName = "sakhalin";
  firewall.allowedTCPPorts = [
    80
    443
  ];
  firewall.allowedUDPPorts = [
    443
    11111
  ];
  firewall.enable = false;

  useDHCP = true;
  useNetworkd = true;
}
