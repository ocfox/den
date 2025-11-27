{ config, ... }:
let
  inherit (config.flake.lib) mkHostModule;
  nixosModules = config.flake.modules.nixos;
in
{
  flake.modules.nixos.wall =
    { pkgs, ... }:
    {
      imports = mkHostModule {
        modules =
          with nixosModules;
          [
            boot
            disko
            facter
            desktop
          ]
          ++ [
            { facter.reportPath = ./facter.json; }
            { services.blueman.enable = true; }
            { networking.firewall.enable = false; }
            {
              environment.systemPackages = [
                pkgs.kodi-gbm
              ];
              users.users.ocfox.extraGroups = [ "input" ];
            }
            # {
            #   vaultix.secrets.vault = {
            #     file = ../../secrets/vault.age;
            #     mode = "640";
            #   };
            # }
          ];
        stateVersion = "25.11";
        # hostKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII3bQFO5LoC420iUupO9kJBBLnujh/QCURi64LvT5mmT root@brick";
      };
    };
}
