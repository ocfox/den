{ config, ... }:
let
  base = with config.flake.modules.nixos; [
    users
    nix
    i18n
    shell
  ];
in
{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      imports = base;
      services = {
        pcscd.enable = true;
        openssh.enable = true;
        tailscale.enable = true;
      };
      hardware.enableRedistributableFirmware = true;
      environment.systemPackages = with pkgs; [
        git
        curl
        bind
        htop
        ripgrep
        age-plugin-yubikey
      ];
    };
}
