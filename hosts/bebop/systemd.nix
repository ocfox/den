{
  network = {
    links."10-eth0" = {
      matchConfig.MACAddress = "58:47:ca:74:70:a5";
      linkConfig.Name = "eth0";
    };
    links."10-eth1" = {
      matchConfig.MACAddress = "58:47:ca:74:70:a6";
      linkConfig.Name = "eth1";
    };
  };
}
