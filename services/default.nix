{ config
, lib
, pkgs
, ...
}: {
  imports = [
    ./swayidle.nix
  ];
}
