{
  hostName = "redfox";
  firewall.allowedTCPPorts = [
    80
    443
    9999
  ];

  useDHCP = false;
  useNetworkd = true;
}
