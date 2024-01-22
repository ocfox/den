{ config }:
let
  uuid = {
    _secret = config.age.secrets.sing-box-uuid.path;
  };
in
{
  log = {
    level = "debug";
  };
  dns = {
    servers = [
      {
        tag = "cf";
        address = "1.1.1.1";
      }
      {
        tag = "local";
        address = "223.5.5.5";
        detour = "direct";
      }
    ];
    rules = [
      {
        domain = [
          "news.ocfox.me"
        ];
        server = "local";
      }
      {
        type = "logical";
        mode = "and";
        rules = [
          {
            "rule_set" = "geosite-geolocation-!cn";
          }
          {
            "rule_set" = "geosite-cn";
            invert = true;
          }
        ];
        server = "cf";
      }
    ];
    final = "local";
  };
  inbounds = [
    {
      tag = "tun-in";
      type = "tun";
      "inet4_address" = "172.19.0.1/30";
      "auto_route" = true;
      "strict_route" = true;
      stack = "system";
      mtu = 9000;
      sniff = true;
    }
  ];
  outbounds = [
    {
      tag = "hy";
      type = "vless";
      server = "93.179.96.154";
      "server_port" = 14051;
      uuid = uuid;
      flow = "xtls-rprx-vision";
      network = "tcp";
      "packet_encoding" = "xudp";
      tls = {
        enabled = true;
        "server_name" = "www.sega.com";
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
    }
    {
      type = "direct";
      tag = "direct";
    }
    {
      type = "dns";
      tag = "dns-out";
    }
  ];
  route = {
    "rule_set" = [
      {
        type = "remote";
        tag = "geoip-cn";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geoip/rule-set/geoip-cn.srs";
        "download_detour" = "hy";
      }
      {
        type = "remote";
        tag = "geosite-cn";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-cn.srs";
        "download_detour" = "hy";
      }
      {
        type = "remote";
        tag = "geosite-geolocation-!cn";
        format = "binary";
        url = "https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-geolocation-!cn.srs";
        "download_detour" = "hy";
      }
    ];
    rules = [
      {
        protocol = "dns";
        outbound = "dns-out";
      }
      {
        "ip_is_private" = true;
        outbound = "direct";
      }
      {
        port = [
          22
        ];
        outbound = "direct";
      }
      {
        domain = [
          "shiori.ocfox.me"
        ];
        outbound = "direct";
      }
      {
        "source_ip_cidr" = [
          "104.200.67.80"
        ];
        outbound = "direct";
      }
      {
        type = "logical";
        mode = "and";
        rules = [
          {
            "rule_set" = "geosite-geolocation-!cn";
            invert = true;
          }
          {
            "rule_set" = [
              "geoip-cn"
              "geosite-cn"
            ];
          }
        ];
        outbound = "direct";
      }
    ];
    final = "hy";
    "auto_detect_interface" = true;
  };
}
