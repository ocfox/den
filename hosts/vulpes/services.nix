{ pkgs }:
{
  openssh.enable = true;

  headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 443;
    settings = {
      ip_prefixes = [
        "fd7a:115c:a1e0::/48"
        "100.64.0.0/10"
      ];
      server_url = "https://vulpes.ocfox.me";
      tls_letsencrypt_hostname = "vulpes.ocfox.me";
      tls_letsencrypt_challenge_type = "TLS-ALPN-01";
      dns_config = {
        override_local_dns = false;
        base_domain = "ocfox.me";
      };
    };
  };
}
