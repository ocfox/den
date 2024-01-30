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
  };
}
