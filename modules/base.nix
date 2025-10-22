{ config, ... }:
let
  base = with config.flake.modules.nixos; [
    users
    boot
    facter
    nix
  ];
in
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      imports = base;
      services = {
        netbird.enable = true;
        openssh.enable = true;
      };

      environment.systemPackages = with pkgs; [
        curl
        bind
        htop
        ripgrep
      ];
    };
}
