{ lib, pkgs }:
let
  jq = lib.getExe pkgs.jq;
  swaymsg = lib.getExe' pkgs.sway "swaymsg";
in
pkgs.writeShellScriptBin "sway-monitor-toggle" ''
  read -r output active <<< \
    "$(${swaymsg} -t get_outputs -r | ${jq} -r '.[] | select(.focused) | "\(.name) \(.active)"')"

  if [ -z "$output" ]; then
    ${swaymsg} output '*' enable
  else
    if [ "$active" != "true" ]; then
      ${swaymsg} output "$output" enable
    else
      ${swaymsg} output "$output" disable
    fi
  fi
''
