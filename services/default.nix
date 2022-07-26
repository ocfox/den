{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./picom.nix
    ./swayidle.nix
  ];
}
