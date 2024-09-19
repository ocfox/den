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
      timeout = 600;
      command = "${lib.getExe swaylock}";
    }
  ];
}
