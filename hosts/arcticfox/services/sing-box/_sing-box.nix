{ config }:
let
  uuid = {
    _secret = config.age.secrets.sing-box-uuid.path;
  };
in
{
  log = {
    disabled = false;
    level = "info";
    timestamp = true;
  };
  dns = {
    servers = [
      {
        tag = "dns_proxy";
        address = "tls://1.1.1.1";
        "address_resolver" = "dns_resolver";
      }
      {
        tag = "dns_direct";
        address = "h3://dns.alidns.com/dns-query";
        "address_resolver" = "dns_resolver";
        detour = "DIRECT";
      }
      {
        tag = "dns_fakeip";
        address = "fakeip";
      }
      {
        tag = "dns_resolver";
        address = "223.5.5.5";
        detour = "DIRECT";
      }
      {
        tag = "block";
        address = "rcode://success";
      }
    ];
    rules = [
      {
        outbound = [
          "any"
        ];
        server = "dns_resolver";
      }
      {
        geosite = [
          "category-ads-all"
        ];
        server = "dns_block";
        "disable_cache" = true;
      }
      {
        geosite = [
          "geolocation-!cn"
        ];
        "query_type" = [
          "A"
          "AAAA"
        ];
        server = "dns_fakeip";
      }
      {
        geosite = [
          "geolocation-!cn"
        ];
        server = "dns_proxy";
      }
    ];
    final = "dns_direct";
    "independent_cache" = true;
    fakeip = {
      enabled = true;
      "inet4_range" = "198.18.0.0/15";
      "inet6_range" = "fc00::/18";
    };
  };
  ntp = {
    enabled = true;
    server = "time.apple.com";
    "server_port" = 123;
    interval = "30m";
    detour = "DIRECT";
  };
  inbounds = [
    {
      type = "tun";
      tag = "tun-in";
      "inet4_address" = "172.19.0.1/30";
      "inet6_address" = "fdfe:dcba:9876::1/126";
      "auto_route" = true;
      "strict_route" = true;
      stack = "mixed";
      sniff = true;
    }
  ];
  outbounds = [
    {
      type = "direct";
      tag = "DIRECT";
    }
    {
      type = "block";
      tag = "REJECT";
    }
    {
      type = "dns";
      tag = "dns-out";
    }
    {
      type = "vless";
      tag = "proxy";
      server = "93.179.96.154";
      "server_port" = 14051;
      uuid = uuid;
      flow = "xtls-rprx-vision";
      tls = {
        enabled = true;
        "server_name" = "www.sega.com";
        insecure = false;
        utls = {
          enabled = true;
          fingerprint = "chrome";
        };
        reality = {
          enabled = true;
          "public_key" = "aiHOBDJJeRGadFks4k1jaCi5lb2VuVs2jOwYSGMQwxk";
          "short_id" = "29994c658a386220";
        };
      };
      network = "tcp";
      "tcp_fast_open" = false;
    }
  ];
  route = {
    rules = [
      {
        protocol = "dns";
        outbound = "dns-out";
      }
      {
        "domain_suffix" = [
          "1password.com"
          "vultr.com"
          "mb3admin.com"
          "rixcloud.io"
          "tempestapp.io"
          "baidu.com"
          "baidu-int.com"
          "erebor.douban.com"
          "gateway.push-apple.com.akadns.net"
          "push.apple.com"
        ];
        domain = [
          "mtalk.google.com"
          "alt1-mtalk.google.com"
          "alt2-mtalk.google.com"
          "alt3-mtalk.google.com"
          "alt4-mtalk.google.com"
          "alt5-mtalk.google.com"
          "alt6-mtalk.google.com"
          "alt7-mtalk.google.com"
          "alt8-mtalk.google.com"
          "alt9-mtalk.google.com"
          "captive.apple.com"
          "time-ios.apple.com"
        ];
        outbound = "DIRECT";
      }
      {
        "domain_keyword" = [
          "github"
        ];
        "domain_suffix" = [
          "github.com"
          "github.io"
          "githubapp.com"
          "githubassets.com"
          "githubusercontent.com"
          "home-intl.console.aliyun.com"
          "googleapis.cn"
          "maying.co"
          "flowercloud.net"
          "socloud.me"
          "ytoo.asia"
          "ytoo.co.uk"
        ];
        domain = [
          "ip.skk.moe"
          "ip.sb"
        ];
        outbound = "proxy";
      }
      {
        geoip = "cn";
        outbound = "DIRECT";
      }
    ];
    "auto_detect_interface" = true;
    final = "proxy";
  };
  experimental = { };
}
