{
  hostName = "civet";
  firewall = {
    enable = false;
    allowedTCPPorts = [
      80
      443
      11283
    ];

    allowedUDPPorts = [
      80
      53
      4000
      443
      11283
    ];

    allowedUDPPortRanges = [
      {
        from = 40000;
        to = 50000;
      }
    ];
  };

  nftables = {
    enable = true;
    ruleset = ''
      table ip nat {
        chain prerouting {
          type nat hook prerouting priority filter; policy accept;
          iifname "ens5" udp dport 40000-50000 counter packets 0 bytes 0 dnat to :4000
        }
      }

      table ip6 nat {
        chain prerouting {
          type nat hook prerouting priority filter; policy accept;
          iifname "ens5" udp dport 40000-50000 counter packets 0 bytes 0 dnat to :4000
        }
      }
    '';
  };

  useDHCP = true;
  useNetworkd = true;
}
