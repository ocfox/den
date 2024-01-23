{
  network = {
    enable = true;
    wait-online.anyInterface = true;
    networks."all" = {
      name = "eno*";
      networkConfig = {
        DHCP = "yes";
        IPv6AcceptRA = true;
      };
    };
  };
}
