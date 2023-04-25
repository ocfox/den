{ lib, pkgs }:
{
  enable = true;
  timeouts = [
    {
      timeout = 900;
      command = "${lib.getExe pkgs.sway} output '*' dpms off";
      resumeCommand = "${lib.getExe pkgs.sway} output '*' dpms on";
    }
  ];
}
