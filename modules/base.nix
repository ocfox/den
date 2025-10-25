{ config, ... }:
let
  base = with config.flake.modules.nixos; [
    users
    nix
    i18n
  ];
in
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      imports = base;
      services = {
        pcscd.enable = true;
        netbird.enable = true;
        openssh.enable = true;
      };

      environment.systemPackages = with pkgs; [
        curl
        bind
        htop
        ripgrep
        age-plugin-yubikey
      ];
    };
}
