{ inputs, config, ... }:
{
  flake.modules.nixos.brick.imports =
    with config.flake.modules.nixos;
    [
      base
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
      {
        imports = [ inputs.vaultix.nixosModules.default ];
        vaultix = {
          settings.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII3bQFO5LoC420iUupO9kJBBLnujh/QCURi64LvT5mmT root@brick";
          # secrets.drive = {
          #   file = ../../secrets/drive.age;
          #   mode = "640";
          # };
          # secrets.vault = {
          #   file = ../../secrets/vault.age;
          #   mode = "640";
          # };
        };
      }
    ];
}
