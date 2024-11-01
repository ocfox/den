{
  hostName = "bebop";
  firewall.allowedTCPPorts = [
    80
    443
    7096
    11283
  ];

  firewall.allowedUDPPorts = [
    80
    443
    7096
    11283
  ];

  useDHCP = true;
  useNetworkd = true;
}
