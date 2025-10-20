{ config, pkgs }:
{
  openssh.enable = true;

  immich.enable = true;

  netbird.enable = true;

  mastodon = {
    # enable = true;
    streamingProcesses = 1;
    localDomain = "ocfox.me";
    smtp.fromAddress = "server@mastodon.ocfox.me";
    extraConfig = {
      WEB_DOMAIN = "mastodon.ocfox.me";
      SINGLE_USER_MODE = "true";
    };
  };

  vaultwarden = {
    enable = true;
    config = {
      SMTP_SECURITY = "starttls";
      SMTP_PORT = 587;
      SMTP_HOST = "smtp.migadu.com";
      SMTP_FROM = "vault@cyans.dev";
      SMTP_USERNAME = "vault@cyans.dev";
      DOMAIN = "https://vault.cyans.dev";
    };
    environmentFile = config.vaultix.secrets.vault.path;
  };

  caddy = {
    enable = true;
    email = "chi@ocfox.me";

    virtualHosts = {

      # "mastodon.ocfox.me" = {
      #   extraConfig = ''
      #     handle_path /system/* {
      #         file_server * {
      #             root /var/lib/mastodon/public-system
      #         }
      #     }

      #     handle /api/v1/streaming/* {
      #         reverse_proxy  unix//run/mastodon-streaming/streaming-1.socket
      #     }

      #     route * {
      #         file_server * {
      #         root ${pkgs.mastodon}/public
      #         pass_thru
      #         }
      #         reverse_proxy * unix//run/mastodon-web/web.socket
      #     }

      #     handle_errors {
      #         root * ${pkgs.mastodon}/public
      #         rewrite 500.html
      #         file_server
      #     }

      #     encode gzip

      #     header /* {
      #         Strict-Transport-Security "max-age=31536000;"
      #     }
      #     header /emoji/* Cache-Control "public, max-age=31536000, immutable"
      #     header /packs/* Cache-Control "public, max-age=31536000, immutable"
      #     header /system/accounts/avatars/* Cache-Control "public, max-age=31536000, immutable"
      #     header /system/media_attachments/files/* Cache-Control "public, max-age=31536000, immutable"
      #   '';
      # };

      "vault" = {
        hostName = "vault.cyans.dev";
        extraConfig = ''
          reverse_proxy localhost:8000 {
            header_up X-Real-IP {remote_host}
          }
        '';
      };

      "immich" = {
        hostName = "immich.ocfox.me";
        extraConfig = ''
          reverse_proxy localhost:2283
        '';
      };
    };
  };
}
