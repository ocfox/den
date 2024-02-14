{ pkgs, username }:
{
  openssh.enable = true;
  tailscale.enable = true;

  atuin = {
    enable = true;
    openFirewall = true;
    openRegistration = true;
  };

  mastodon = {
    enable = true;
    streamingProcesses = 1;
    localDomain = "ocfox.me";
    smtp.fromAddress = "server@mastodon.ocfox.me";
    extraConfig = {
      WEB_DOMAIN = "mastodon.ocfox.me";
      SINGLE_USER_MODE = "true";
    };
  };

  shiori = {
    enable = true;
  };

  uptime-kuma = {
    enable = true;
    settings = {
      PORT = "9000";
    };
  };

  bin-paste = {
    enable = true;
    maxPasteSize = 1048576;
    bufferSize = 2000;
  };

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

      "mastodon.ocfox.me" = {
        extraConfig = ''
          handle_path /system/* {
              file_server * {
                  root /var/lib/mastodon/public-system
              }
          }

          handle /api/v1/streaming/* {
              reverse_proxy  unix//run/mastodon-streaming/streaming-1.socket
          }

          route * {
              file_server * {
              root ${pkgs.mastodon}/public
              pass_thru
              }
              reverse_proxy * unix//run/mastodon-web/web.socket
          }

          handle_errors {
              root * ${pkgs.mastodon}/public
              rewrite 500.html
              file_server
          }

          encode gzip

          header /* {
              Strict-Transport-Security "max-age=31536000;"
          }
          header /emoji/* Cache-Control "public, max-age=31536000, immutable"
          header /packs/* Cache-Control "public, max-age=31536000, immutable"
          header /system/accounts/avatars/* Cache-Control "public, max-age=31536000, immutable"
          header /system/media_attachments/files/* Cache-Control "public, max-age=31536000, immutable"
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
