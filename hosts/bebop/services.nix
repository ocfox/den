{ pkgs }:
{
  openssh.enable = true;
  tailscale.enable = true;

  pppd = {
    enable = true;
    peers.edpnet = {
      enable = true;
      config = ''
        plugin pppoe.so eth0

        name "2-29-507"
        password "229507"

        ifname ppp-wan

        usepeerdns
        defaultroute
      '';
    };
  };

  resolved.enable = false;

  kresd = {
    enable = true;
    listenPlain = [
      "127.0.0.1:53"
      "[::1]:53"
      "10.0.0.1:53"
      "[fd23:3333:3333::1]:53"
    ];
  };

  kea.dhcp4 = {
    enable = true;
    settings = {
      interfaces-config = {
        interfaces = [ "br-lan" ];
      };
      subnet4 = [
        {
          id = 1;
          subnet = "10.0.0.0/24";
          pools = [ { pool = "10.0.0.2 - 10.0.0.100"; } ];
          option-data = [
            {
              name = "routers";
              data = "10.0.0.1";
            }
            {
              name = "domain-name-servers";
              data = "10.0.0.1";
            }
          ];
        }
      ];
    };
  };

  radvd = {
    enable = true;
    config = ''
      interface br-lan {
        AdvSendAdvert on;
        MinRtrAdvInterval 3;
        MaxRtrAdvInterval 10;
        prefix ::/64 {
          AdvOnLink on;
          AdvAutonomous on;
          AdvRouterAddr on;
        };
        RDNSS fd23:3333:3333::1 { };
      };
    '';
  };
}
