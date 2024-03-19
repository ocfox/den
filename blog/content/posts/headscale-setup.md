---
title:  "Tailscale with Headscale?"
date: "2024-02-06"
tags: ["tailscale", "network", "nixos", "headscale"]
---

Last month, I got a Dell R730xd and paid much time on **Fighting with ChinaTelecom**.
Finally, I lost the war. However, fortunately, Tailscale can _effectively(maybe)_ address my issue.

I used Tailscale in the past, but was stopped by **Chinese 'Premium' Network**. High latency and packet loss rate make me crazy.

{{< collapse summary="And 'they' provides services, just like Google." >}}
<u>Haha, actually, I'm not sensitive to this at all. I'm not a privacy-paranoid person.</u>
{{< /collapse >}}
*"Why not selfhost it?"*, a real man(character I made up) said. So I host it on a server with *CN2*[^1] network.

Got to admit, Tailscale's *Hole Punching* works seamlessly without any configuration needed – it's fantastic!

So, log into NixOS first(*If you're not using NixOS, I recommend giving it a try. It's a must-try!*).
Then quickly finish configure it about 10 minutes. 
```nix
  headscale = {
    enable = true;
    # Specify listening on all available interfaces with 0.0.0.0
    address = "0.0.0.0";
    port = 443; # Any port you like
    settings = {
      # use "http://weed.ocfox.me" if you don't need tls
      server_url = "https://weed.ocfox.me";
      # Don't forget forwaring if you use other port
      tls_letsencrypt_hostname = "weed.ocfox.me";
      tls_letsencrypt_challenge_type = "TLS-ALPN-01";
      # Any base_domain you like, in this case
      # your nodes will named `<nodename>.<user>.sex.allnight`
      dns_config.base_domain = "sex.allnight";
      # Add this to avoid noisy warning
      ip_prefixes = [
        "fd7a:115c:a1e0::/48"
        "100.64.0.0/10"
      ];
    };
  };
```
{{< collapse summary="Copy this without commnets" >}}
```nix
  headscale = {
    enable = true;
    address = "0.0.0.0";
    port = 443;
    settings = {
      server_url = "https://weed.ocfox.me";
      tls_letsencrypt_hostname = "weed.ocfox.me";
      tls_letsencrypt_challenge_type = "TLS-ALPN-01";
      dns_config.base_domain = "sex.allnight";
    };
  };
```
{{< /collapse >}}
"Why is it `headscale` instead of `services.headscale`?" -- I use haumea.[^2]
Login headscale server to create a user
```fish
  headscale namespaces create ocfox
```

Now enable tailscale on your _nodes_ in one line.
```nix
  services.tailscale.enable = true;
```
After rebuild, log into headscale.
```fish
[ocfox@bed]$ sudo tailscale up --login-server https://weed.ocfox.me
To authenticate, visit:

        https://weed.ocfox.me/register/nodekey:pleasefuckmefrommorningtothemidnight
```
Visit this site is useless, it has not been implemented yet.
But it can be auth at headscale server.
```fish
[root@headserver:~]#
headscale nodes register -k nodekey:pleasefuckmefrommorningtothemidnight -u ocfox
```

```fish
[ocfox@bed]$ tailscale status 
100.64.0.1 bed ocfox linux -
```
Then use same way register another machine `sofa`.
You can communication sofa and bed behind NAT now(I guess it should work).
If not work, don't worrid, at least my(your) nodes connect to headscale server is fast.

If you are on darwin(macos), congratulations you've fallen into a well.
To specify login server with tailscale app(installed by App store), just following this
```sh
$ /Applications/Tailscale.app/Contents/MacOS/Tailscale up --login-server https://^_^
```
And check nodekey on another terminal
```sh
$ tailscale status
  ...
    https://weed.ocfox.me/register/nodekey:pleasefuckmefrommorningtothemidnight
```

Of course, I(you) need to use magicDNS. However, if you happen to live in China and rely on a network proxy, magicDNS may pose some issues.
It will prioritize the use of DNS provided by `services.headscale.settings.dns_config.nameservers` for all access.
Currently, I don't have a good solution, and I've resolve this issue by using a system proxy instead of TUN.

**All last, Why I must use proxy to see this world?** -- "Maybe I fucked a dog in my past life."

If there's anything I fucked up, please hit 'Suggest Changes' at the top.

[^1]: <small>[AS4809 - a comprehensive range of high quality network services to customers around the world.](https://www.ctamericas.com/company/global-network/cn2/)</small>
[^2]: <small>[haumea - Filesystem-based module system for Nix](https://github.com/nix-community/haumea)</small>
