{
  hostName = "civet";
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

  nameservers = [ "1.1.1.1" ];

  useDHCP = true;
  useNetworkd = true;
}
