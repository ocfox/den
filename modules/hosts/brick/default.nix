{ config, ... }:
let
  inherit (config.flake.lib) mkHostModule;
  nixosModules = config.flake.modules.nixos;
  homeModules = config.flake.modules.homeManager;
in
{
  flake.modules.nixos.brick.imports = mkHostModule {
    nixosModules = with nixosModules; [
      boot
      disko
      facter
      desktop
      android
    ];
    homeModules = with homeModules; [
      desktop
    ];
    stateVersion = "25.11";
    # hostKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII3bQFO5LoC420iUupO9kJBBLnujh/QCURi64LvT5mmT root@brick";
    extraModules = [
      { facter.reportPath = ./facter.json; }
      { services.blueman.enable = true; }
      { networking.firewall.enable = false; }
      { boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; }
      # {
      #   vaultix.secrets.vault = {
      #     file = ../../secrets/vault.age;
      #     mode = "640";
      #   };
      # }
    ];
  };
}
