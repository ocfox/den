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

  bin-paste.enable = true;

  caddy = {
    enable = true;
    email = "i@ocfox.me";
    virtualHosts = {

      "shiori" = {
        hostName = "shiori.ocfox.me";
        extraConfig = ''
          reverse_proxy localhost:8080
        '';
      };

      "bin" = {
        hostName = "pb.ocfox.me";
        extraConfig = ''
          reverse_proxy localhost:8000
        '';
      };

      "bin2" = {
        hostName = "pastb.in";
        extraConfig = ''
          reverse_proxy localhost:8000
        '';
      };

    };
  };
}
