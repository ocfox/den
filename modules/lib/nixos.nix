{
  inputs,
  config,
  withSystem,
  ...
}:
let
  inherit (inputs.nixpkgs.lib) mapAttrs nixosSystem;
in
{
  flake.lib = {
    mkHostModule =
      {
        nixosModules ? [ ],
        homeModules ? [ ],
        stateVersion,
        hostKey,
        extraModules ? [ ],
      }:
      [
        config.flake.modules.nixos.base
        config.flake.modules.nixos.home-manager
        {
          home-manager.users.ocfox.imports = [ config.flake.modules.homeManager.base ] ++ homeModules;
          system.stateVersion = stateVersion;
        }
        {
          imports = [ inputs.vaultix.nixosModules.default ];
          vaultix.settings.hostPubkey = hostKey;
        }
      ]
      ++ nixosModules
      ++ extraModules;

    mkNixos =
      system: name:
      withSystem system (
        { pkgs, ... }:
        nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit inputs; };
          modules = [
            config.flake.modules.nixos.${name}
            {
              networking.hostName = name;
              nixpkgs.hostPlatform = system;
            }
          ];
        }
      );

    mkNixosFromAttrs = hosts: mapAttrs (name: system: config.flake.lib.mkNixos system name) hosts;
  };
}
