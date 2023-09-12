{ lib, pkgs }:
pkgs.writeShellScriptBin "powermenu" ''
  echo '
    reboot = systemctl reboot
    poweroff = systemctl poweroff
    suspend = systemctl suspend
    sleep = systemctl hybrid-sleep
  ' | \
  ${lib.getExe' pkgs.kickoff "kickoff"} --from-stdin
''
