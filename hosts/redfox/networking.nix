{
  hostName = "redfox";
  firewall.allowedTCPPorts = [
    80
    443
  ];

  useDHCP = false;
  useNetworkd = true;
}
