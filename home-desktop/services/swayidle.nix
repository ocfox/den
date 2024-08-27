{
  lib,
  pkgs,
  root,
}:
let
  inherit (root.pkgs) swaylock;
in
{
  enable = true;
  timeouts = [
    {
      timeout = 300;
      command = "${lib.getExe swaylock}";
    }
  ];
}
