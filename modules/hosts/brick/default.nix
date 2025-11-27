{ config, ... }:
let
  inherit (config.flake.lib) mkHostModule;
  nixosModules = config.flake.modules.nixos;
in
{
  flake.modules.nixos.brick.imports = mkHostModule {
    stateVersion = "25.11";
    # hostKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII3bQFO5LoC420iUupO9kJBBLnujh/QCURi64LvT5mmT root@brick";
    modules = with nixosModules; [
      # Base system modules
      boot
      disko
      facter
      android

      # The central desktop module that imports all user apps
      desktop

      # Host-specific overrides
      { facter.reportPath = ./facter.json; }
      { services.blueman.enable = true; }
      { networking.firewall.enable = false; }
      { boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; }
    ];
  };
}
