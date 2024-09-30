{ pkgs }:
{
  openssh.enable = true;
  tailscale = {
    enable = true;

    derper = {
      enable = true;
      package = pkgs.tailscale-derp.derper;
      domain = "cyans.dev";
      verifyClients = true;
    };
  };
}
