{ pkgs, username }:
{
  openssh.enable = true;
  tailscale.enable = true;

  atuin = {
    enable = true;
    openFirewall = true;
    openRegistration = true;
  };

  shiori = {
    enable = true;
  };

  # transfer-sh = {
  #   enable = true;
  #   settings = {
  #     LISTENER = ":7777";
  #     RANDOM_TOKEN_LENGTH = 2;
  #   };
  # };

  uptime-kuma = {
    enable = true;
    settings = {
      PORT = "9000";
    };
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

      "atuin" = {
        hostName = "atuin.ocfox.me";
        extraConfig = ''
          reverse_proxy localhost:8888
        '';
      };

      "uptime" = {
        hostName = "uptime.ocfox.me";
        extraConfig = ''
          reverse_proxy localhost:9000
        '';
      };

      "up" = {
        hostName = "up.ocfox.me";
        extraConfig = ''
          reverse_proxy localhost:9000
          redir / /status/all
        '';
      };

      # "transfer" = {
      #   hostName = "red.ocfox.me";
      #   extraConfig = ''
      #     reverse_proxy localhost:7777
      #   '';
      # };

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
