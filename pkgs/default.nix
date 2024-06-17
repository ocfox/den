{ inputs, ... }:
{
  perSystem = { lib, system, pkgs, ... }:
    let
      inherit (inputs.self.lib) genDirAttrs;
    in
    {
      packages =
        genDirAttrs ./. (
          name: pkgs.callPackage (./. + "/${name}") { }
        );
    };
}
