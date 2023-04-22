{ pkgs }:
with pkgs;
[
  nil
  nixpkgs-fmt
  texlab

  bitwarden
  waybar
  foot
  wl-clipboard
  swayidle
  showmethekey
  gh
  nixpkgs-review

  lolcat
  tree
  element-desktop
  qbittorrent
  tdesktop

  firefox-wayland
  qutebrowser

  # factorio-experimental

  ncspot
  sptlrx
  playerctl
  cava
  vlc
  wf-recorder

  nur.repos.linyinfeng.wemeet
  nur.repos.linyinfeng.icalingua-plus-plus
  nur.repos.xddxdd.qq

  texlive.combined.scheme-medium

  (
    pkgs.writeShellScriptBin "record-status" ''
      #!/usr/bin/env bash
      pid=`pgrep wf-recorder`
      status=$?

      if [ $status != 0 ]
      then
        echo '';
      else
        echo '';
      fi;
    ''
  )

  (
    pkgs.writeShellScriptBin "screen-recorder-toggle" ''
      #!/usr/bin/env bash
      pid=`${pkgs.procps}/bin/pgrep wf-recorder`
      status=$?

      if [ $status != 0 ]
      then
        ${lib.getExe pkgs.wf-recorder} -g "$(${lib.getExe pkgs.slurp})" -f $HOME/Videos/record/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
      else
        ${pkgs.procps}/bin/pkill --signal SIGINT wf-recorder
      fi;
    ''
  )

  (
    pkgs.writeShellScriptBin "power-menu" ''
      #!/usr/bin/env bash
      options="shutdown\nreboot\nsuspend\nexit sway"

      selection="$(${pkgs.coreutils}/bin/echo -e $options | \
                   ${lib.getExe pkgs.bemenu} -i -l 4 -c -W 0.3)"

      case $selection in
      	shutdown) ${pkgs.systemd}/bin/systemctl poweroff
      		exit 0
      		;;
      	reboot) ${pkgs.systemd}/bin/systemctl reboot
      		exit 0
      		;;
      	suspend) ${pkgs.systemd}/bin/systemctl suspend
      		exit 0
      		;;
      esac''
  )
]
