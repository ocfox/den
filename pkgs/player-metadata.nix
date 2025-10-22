{ lib, pkgs }:
pkgs.writeShellScript "player-metadata" ''
  if [[ $(${lib.getExe pkgs.playerctl} metadata artist) ]]
  then
    echo $(${lib.getExe pkgs.playerctl} metadata artist) - $(${lib.getExe pkgs.playerctl} metadata title)
  else
    echo $(${lib.getExe pkgs.playerctl} metadata title)
  fi
''
