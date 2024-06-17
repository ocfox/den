{ lib, ... } @ args: {
  flake.lib =
    (lib.extend (final: _: {
      extLib = import ./lib.nix (args // { lib = final; });
    })).extLib;
}
