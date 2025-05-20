{ pkgs }:
{
  openssh.enable = true;

  tailscale.enable = true;

  immich.enable = true;

  caddy = {
    enable = true;
    email = "chi@ocfox.me";

    virtualHosts = {

      "immich" = {
        hostName = "immich.ocfox.me";
        extraConfig = ''
          reverse_proxy localhost:2283
        '';
      };
    };
  };
}
