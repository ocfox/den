{ config, ... }:
{
  flake.modules.nixos.brick.imports =
    with config.flake.modules.nixos;
    [
      base
      disko
      shell
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

      {
        services.blueman.enable = true;
      }
    ];
}
