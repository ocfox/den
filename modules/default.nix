{
  default =
    { ... }:
    {
      imports = [
        (import ./shadowsocks.nix)
        (import ./tailscale-derp.nix)
      ];
    };
}
