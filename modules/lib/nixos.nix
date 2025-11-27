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
        modules ? [ ],
        stateVersion,
        hostKey ? "",
      }:
      [
        config.flake.modules.nixos.base
        { system.stateVersion = stateVersion; }
      ]
      ++ (
        if hostKey != "" then
          [
            {
              imports = [ inputs.vaultix.nixosModules.default ];
              vaultix.settings.hostPubkey = hostKey;
            }
          ]
        else
          [ ]
      )
      ++ modules;

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
