{
  hostName = "civet";
  firewall.allowedTCPPorts = [
    80
    443
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
