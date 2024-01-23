{
  network = {
    enable = true;
    wait-online.anyInterface = true;
    networks."all" = {
      name = "ens*";
      networkConfig = {
        DHCP = "yes";
        IPv6AcceptRA = true;
      };
    };
  };
}
