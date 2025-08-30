{
  default =
    { ... }:
    {
      imports = [
        (import ./shadowsocks.nix)
        (import ./xwayland-satellite.nix)
        # (import ./tailscale-derp.nix)
      ];
    };
}
