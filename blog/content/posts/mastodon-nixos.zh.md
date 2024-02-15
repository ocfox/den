---
title:  "终于, 我也有了自己的Mastodon服务器"
date: "2024-02-15"
tags: ["nixos", "nix", "mastodon", "caddy"]
summary: "在NixOS上搭建自己的Mastodon服务器，并使用Caddy作为反向代理。"
---

### Why?

我一直没有使用社交媒体的习惯，像是Twitter, Weibo之类。但是经常看到大家在聊天里分享链接，难免会想尝试一下。
我很喜欢Misskey的UI，好看。但是移动客户端很重要，如果没有的话就基本等于不会习惯性的访问。
简单的尝试之后 Mastodon 满足了大多数我的要求。

### NixOS configuration

在NixOS上部署很简单，只需要将DNS解析到相应的机器并填好设置，没有其他的步骤。
需要做的域名只有 `WEB_DOMAIN`。

```nix
  services.mastodon = {
    enable = true;
    streamingProcesses = 1; # 推荐处理器核心-1
    localDomain = "ocfox.me";
    smtp.fromAddress = "server@mastodon.ocfox.me";
    extraConfig = {
      WEB_DOMAIN = "mastodon.ocfox.me";
      SINGLE_USER_MODE = "true";
    };
  };
```
在最好的情况下，localDomain应该和WEB_DOMAIN保持一致，也就是并不需要单独设置WEB_DOMAIN。
但是我相信，你应该已经在它上面提供了别的内容吧，比如homepage之类的，不过mastodon允许我们这么做[^1]。
只需要在localDomain上提供webfinger就好。

接下来是Caddy的配置，记得替换email and WEB_DOMAIN。
```nix
  # 保证caddy具有mastodon web socket的读写权限
  systemd.services.caddy.serviceConfig.SupplementaryGroups = [ "mastodon" ];

  services.caddy = {
    enable = true;
    email = "<email for acme>";
    virtualHosts = {
      "<WEB_DOMAIN>" = {
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
        '';
    };
  };
```

nixos-rebuild之后，你就可以通过域名访问你的mastodon server啦。
接下来需要为自己创建一个用户。
```sh
mastodon-tootctl accounts create USERNAME --email=YOUR_EMAIL --confirmed --role=Owner
```
你将会看到生成的密码打印在下面。

### Something needed

如果使用了不同的localDomain，那么还需要在 localDomain 上提供webfinger。(只是单用户或者几个用户的话可以这么做),
不然请参考manual[^1]。
```path
https://<WEB_DOMAIN>/.well-known/webfinger?resource=acct:<USERNAME>@<localDomain>
```
提供的json 复制到下面的路径就好。
```path
https://<localDomain>/.well-known/webfinger
```
如果是github pages并且部署后无法访问这个路径，可以在根目录添加空白文件`.nojekyll`解决。

如果你之前在其他mastodon兼容的服务器注册过账户，那么也可以简单的迁移到新的账户。
在设置里找到 账户->从其它账号迁入。接下来按照说明做就好，迁移完成后旧账户就不能正常使用了(大概)。

[^1]: [Using a different domain name for Mastodon and the users it serves](https://github.com/felx/mastodon-documentation/blob/master/Running-Mastodon/Serving_a_different_domain.md)
