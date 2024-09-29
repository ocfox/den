{
  default =
    { ... }:
    {
      imports = [
        (import ./shadowsocks.nix)
      ];
    };
}
