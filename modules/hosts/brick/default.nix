{ inputs, config, ... }:
{
  flake.modules.nixos.brick.imports =
    with config.flake.modules.nixos;
    [
      base
      boot
      disko
      shell
      facter
      desktop
    ]
    ++ [
      {
        home-manager.users.ocfox.imports = with config.flake.modules.homeManager; [
          desktop
          editor
          git
          shell
        ];
        facter.reportPath = ./facter.json;
        system.stateVersion = "25.11";
      }

      { services.blueman.enable = true; }
      { boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; }
      {
        imports = [ inputs.vaultix.nixosModules.default ];
        vaultix = {
          settings.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII3bQFO5LoC420iUupO9kJBBLnujh/QCURi64LvT5mmT root@brick";
          # secrets.vault = {
          #   file = ../../secrets/vault.age;
          #   mode = "640";
          # };
        };
      }
    ];
}
