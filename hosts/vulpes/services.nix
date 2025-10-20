{ pkgs }:
{
  openssh.enable = true;

  resolved.enable = false;
  dnsproxy = {
    enable = true;
    flags = [
      "--cache"
      "--cache-optimistic"
      "--edns"
    ];
    settings = {
      bootstrap = [
        "8.8.8.8"
        "119.29.29.29"
        "tcp://223.6.6.6:53"
      ];
      listen-addrs = [ "0.0.0.0" ];
      listen-ports = [ 53 ];
      upstream-mode = "parallel";
      upstream = [
        "https://1.1.1.1/dns-query"
        "h3://dns.alidns.com/dns-query"
        "tls://dot.pub"
      ];
    };
  };

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
