{ pkgs }:
{
  openssh.enable = true;

  headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 443;
    settings = {
      serverUrl = "https://vulpes.ocfox.me";
      tls_letsencrypt_hostname = "vulpes.ocfox.me";
      tls_letsencrypt_challenge_type = "TLS-ALPN-01";
      dns_config.base_domain = "ocfox.me";
    };
  };
}
