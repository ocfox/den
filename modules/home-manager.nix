{ inputs, ... }:
{
  flake.modules.nixos.home-manager = {
    imports = [ inputs.home-manager.nixosModules.default ];

    programs.dconf.enable = true;
    home-manager = {
      useGlobalPkgs = true;

      users.ocfox.imports = [
        (
          { osConfig, ... }:
          {
            home.stateVersion = osConfig.system.stateVersion;
          }
        )
      ];
    };
  };
}
