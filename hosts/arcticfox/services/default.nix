{ pkgs }:
{
  openssh.enable = true;

  # TODO: meadia space
  jellyfin = {
    enable = true;
    openFirewall = true;
    user = "transmission";
  };

  transmission = {
    enable = true;
    user = "transmission";
    openFirewall = true;
    openRPCPort = true;
    webHome = pkgs.flood-for-transmission;
    settings = {
      rpc-bind-address = "0.0.0.0";
      rpc-whitelist = "100.64.0.*, 192.168.*.*";
      rpc-host-whitelist-enabled = false;
    };
  };

  tailscale.enable = true;
}
