{ inputs, ... }:
{
  genDirAttrs =
    dir:
    let
      inherit (inputs.nixpkgs.lib) genAttrs attrNames filterAttrs;
      inherit (builtins) readDir;
    in
    genAttrs (attrNames (filterAttrs (_: v: v == "directory") (readDir dir)));
}
