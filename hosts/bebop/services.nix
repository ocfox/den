{ pkgs }:
{
  openssh.enable = true;
  tailscale.enable = true;

  proxmox-ve.enable = true;
  ntfy-sh.enable = true;
}
