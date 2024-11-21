{ pkgs }:
{
  openssh.enable = true;

  resolved.enable = false;
  kresd = {
    enable = true;
    listenPlain = [ "127.0.0.1:53" ];
  };

  tailscale = {
    enable = true;

    derper = {
      enable = true;
      package = pkgs.tailscale-derp.derper;
      domain = "cyans.dev";
      verifyClients = true;
    };
  };

  nginx.virtualHosts."cyans.dev".enableACME = true;
}
