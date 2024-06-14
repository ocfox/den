{
  services.caddy.serviceConfig.SupplementaryGroups = [ "mastodon" ];

  network = {
    enable = true;
    wait-online.anyInterface = true;
    networks."all" = {
      name = "ens*";
      address = [
        "104.200.67.80/24"
        "2602:ff75:7:4724::1/48"
      ];
      routes = [
        { Gateway = "2602:ff75:7::1"; }
        { Gateway = "104.200.67.1"; }
      ];
    };
  };
}
