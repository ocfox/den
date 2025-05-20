{
  network = {
    enable = true;
    networks = {
      "eth0" = {
        matchConfig.MACAddress = "96:00:04:4e:89:6d";
        address = [
          "94.130.74.166/32"
          "2a01:4f8:1c1c:dd43::1/64"
        ];
        routes = [
          { Gateway = "fe80::1"; }
          {
            Gateway = "172.31.1.1";
            GatewayOnLink = true;
          }
        ];
        linkConfig.RequiredForOnline = "routable";
      };
    };
  };
}
