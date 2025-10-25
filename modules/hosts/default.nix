{ config, ... }:
let
  inherit (config.flake.lib) mkNixosFromAttrs;
in
{
  flake.nixosConfigurations = mkNixosFromAttrs {
    brick = "x86_64-linux";
    cave = "aarch64-linux";
  };
}
