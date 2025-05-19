{
  hostName = "chi";

  firewall = {
    enable = false;
  };

  nameservers = [
    "2a01:4ff:ff00::add:1"
    "2a01:4ff:ff00::add:2"
  ];

  defaultGateway6 = {
    address = "fe80::1";
    interface = "eth0";
  };
  dhcpcd.enable = false;
  usePredictableInterfaceNames = false;
  interfaces = {
    eth0 = {
      ipv4.addresses = [
        {
          address = "100.64.12.6";
          prefixLength = 32;
        }
      ];
      ipv6.addresses = [
        {
          address = "2a01:4f8:1c1c:dd43::1";
          prefixLength = 64;
        }
        {
          address = "fe80::9400:4ff:fe4e:896d";
          prefixLength = 64;
        }
      ];
      ipv6.routes = [
        {
          address = "fe80::1";
          prefixLength = 128;
        }
      ];
    };
  };
}
