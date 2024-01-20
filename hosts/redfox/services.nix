{ pkgs, username }:
{
  openssh.enable = true;

  atuin = {
    enable = true;
    openFirewall = true;
    openRegistration = true;
  };

  shiori = {
    enable = true;
  };

  caddy = {
    enable = true;
    virtualHosts = {

      "shiori" = {
        hostName = "shiori.ocfox.me";
        extraConfig = ''
          reverse_proxy 127.0.0.1:8080
        '';
      };
    };
  };
}
