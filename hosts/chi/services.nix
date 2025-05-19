{ pkgs }:
{
  openssh.enable = true;

  tailscale.enable = true;

  # nginx.virtualHosts."cyans.dev".enableACME = true;
}
