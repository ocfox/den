{ lib
, pkgs
}:
with pkgs;
[
  bitwarden
  wl-clipboard
  swayidle
  showmethekey
  element-desktop
  qbittorrent
  tdesktop
  firefox-wayland

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
  (
    writeShellScriptBin "mac-shot" ''
      file=/tmp/xxx.png
      ${lib.getExe sway-contrib.grimshot} --notify save area /tmp/src.png >> /dev/null 2>&1

      ${imagemagick}/bin/convert /tmp/src.png \
        \( +clone -alpha extract \
        -draw 'fill black polygon 0,0 0,8 8,0 fill white circle 8,8 8,0' \
        \( +clone -flip \) -compose Multiply -composite \
        \( +clone -flop \) -compose Multiply -composite \
        \) -alpha off -compose CopyOpacity -composite /tmp/output.png

      ${imagemagick}/bin/convert /tmp/output.png -bordercolor none -border 20 \
      \( +clone -background black -shadow 80x8+15+15 \) \
        +swap -background transparent -layers merge +repage $file

      ${wl-clipboard}/bin/wl-copy -t image/png < $file
      ${libnotify}/bin/notify-send "macshot copied"
      rm /tmp/src.png /tmp/output.png
    ''
  )
]
