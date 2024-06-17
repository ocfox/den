{ inputs, ... }:
let

  genDirAttrs =
    dir:
    let
      inherit (inputs.nixpkgs.lib)
        genAttrs
        attrNames
        filterAttrs
        ;
      inherit (builtins) readDir;
    in
    genAttrs (
      attrNames (filterAttrs (_: v: v == "directory") (readDir dir))
    );
  # inherit (inputs.self.lib) genDirAttrs;
in
{
  perSystem = { lib, system, pkgs, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlay = [
          inputs.self.overlays.default
        ];
      };

      packages =
        genDirAttrs ./. (
          name: pkgs.${name}
        );
    };


  flake.overlays.default = final: prev:
    genDirAttrs ./. (
      name: final.callPackage (./. + "/${name}") { }
    );
}
