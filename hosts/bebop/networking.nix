{
  hostName = "bebop";

  useDHCP = false;
  useNetworkd = true;

  firewall.enable = false;

  nameservers = [
    "223.5.5.5"
    "1.1.1.1"
  ];

  nat.enable = false;

  nftables = {
    enable = true;

    ruleset = ''
      table inet filter {
        chain input {
          type filter hook input priority 0; policy drop;

          iifname { "br-lan" } accept comment "Allow local network to access the router"
          iifname "ppp-wan" ct state { established, related } accept comment "Allow established traffic"
          iifname "ppp-wan" icmp type { echo-request, destination-unreachable, time-exceeded } counter accept comment "Allow select ICMP"
          iifname "ppp-wan" counter drop comment "Drop all other unsolicited traffic from wan"
          iifname "lo" accept comment "Accept everything from loopback interface"
        }
        chain forward {
          type filter hook forward priority filter; policy drop;

          iifname { "br-lan" } oifname { "ppp-wan" } accept comment "Allow trusted LAN to WAN"
          iifname { "ppp-wan" } oifname { "br-lan" } ct state { established, related } accept comment "Allow established back to LANs"
        }
      }

      table ip nat {
        chain postrouting {
          type nat hook postrouting priority 100; policy accept;
          oifname "ppp-wan" masquerade
        }
      }
    '';
  };
}
