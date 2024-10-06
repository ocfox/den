{ pkgs }:
{
  openssh.enable = true;

  tailscale.enable = true;

  nginx = {
    enable = true;
    virtualHosts."vulpes.ocfox.me" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        return = "200 '<html><body>The Vulpes.</body></html>'";
        extraConfig = ''
          default_type text/html;
        '';
      };
    };
  };
}
