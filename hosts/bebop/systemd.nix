{
  network = {
    # PHYSICAL
    links."10-eth0" = {
      matchConfig.MACAddress = "58:47:ca:74:70:a5";
      linkConfig.Name = "eth0";
    };
    # PPP
    networks."10-ppp-wan" = {
      matchConfig = {
        Name = "ppp-wan";
      };
      networkConfig = {
        IPv6AcceptRA = true;
        KeepConfiguration = true;
      };
      DHCP = "ipv6";
      dhcpV6Config = {
        WithoutRA = "solicit";
      };
    };

    netdevs."05-br-lan" = {
      netdevConfig = {
        Name = "br-lan";
        Kind = "bridge";
      };
    };
    networks."05-br-lan" = {
      matchConfig = {
        Name = "br-lan";
      };
      address = [
        "10.0.0.1/24"
        "fd23:3333:3333::1/64"
      ];
      networkConfig = {
        ConfigureWithoutCarrier = true;
        DHCPPrefixDelegation = true;
        IPv6AcceptRA = false;
      };
    };

    # PHYSICAL
    links."10-eth1" = {
      matchConfig.MACAddress = "58:47:ca:74:70:a6";
      linkConfig.Name = "eth1";
    };
    networks."10-eth1" = {
      matchConfig = {
        Name = "eth1";
      };
      networkConfig = {
        Bridge = "br-lan";
      };
    };

  };
}
