{ config, ... }:
let
  inherit (config.flake.lib) mkHostModule;
  nixosModules = config.flake.modules.nixos;
in
{
  flake.modules.nixos.brick.imports = mkHostModule {
    stateVersion = "25.11";
    # hostKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIoT6gPSX5fd1bGnANf5xj1HMKEhNgA3CAN0TgiAP6lJ root@brick";
    modules = with nixosModules; [
      # Base system modules
      boot
      disko
      facter
      # android

      desktop

      { facter.reportPath = ./facter.json; }
      { services.blueman.enable = true; }
      { networking.nameservers = [ "10.10.0.157" ]; }
      { networking.firewall.enable = false; }
      { boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; }
    ];
  };
}
