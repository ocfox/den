{ config }:
{
  openssh.enable = true;

  tailscale.enable = true;

  immich.enable = true;

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
