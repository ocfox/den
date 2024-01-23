{
  network = {
    enable = true;
    networks."ens3" = {
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      matchConfig.name = "ens3";
      linkConfig.RequiredForOnline = "routable";
      # address = [
      #   "104.200.67.80/24"
      #   "2602:ff75:7:4724::/64"
      # ];
      # routes = [
      #   { routeConfig.Gateway = "2602:ff75:7::1"; }
      #   { routeConfig.Gateway = "104.200.67.1"; }
      # ];
    };
  };
}
