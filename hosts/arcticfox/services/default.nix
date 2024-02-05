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
      rpc-whitelist = "127.0.0.1,192.168.*.*";
    };
  };
}
