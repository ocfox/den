{
  lib,
  inputs,
  config,
  withSystem,
  ...
}:
{
  flake.lib = {
    mkNixos =
      system: name:
      withSystem system (
        { pkgs, ... }:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            config.flake.modules.nixos.${name}
            {
              networking.hostName = name;
              nixpkgs.hostPlatform = system;
            }
          ];
        }
      );

    mkNixosFromAttrs = hosts: lib.mapAttrs (name: system: config.flake.lib.mkNixos system name) hosts;
  };
}
