{
  network = {
    enable = true;
    wait-online.anyInterface = true;
    networks."eno1" = {
      name = "eno1";
      networkConfig = {
        DHCP = "yes";
        IPv6AcceptRA = true;
      };
    };
    # interface: iDrac <-> eno4
    networks."eno4" = {
      name = "eno4";
      address = [ "192.168.109.2/24" ];
      routes = [ { routeConfig.Gateway = "192.168.109.190"; } ];
      networkConfig = { };
    };
  };
}
