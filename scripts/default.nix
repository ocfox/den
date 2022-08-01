{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    (pkgs.writeShellScriptBin "icalingua" ''
      #!/usr/bin/env bash
      icalingua-plus-plus --enable-features=UseOzonePlatform --ozone-platform=wayland
    '')

    (
      pkgs.writeShellScriptBin "spoti" ''
        #!/usr/bin/env bash
        spotify --enable-features=UseOzonePlatform --ozone-platform=wayland
      ''
    )

    (
      pkgs.writeShellScriptBin "element" ''
        #!/usr/bin/env bash
        element-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland
      ''
    )

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
          ${pkgs.wf-recorder}/bin/wf-recorder -g "$(${pkgs.slurp}/bin/slurp)" -f $HOME/Videos/record/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
        else
          ${pkgs.procps}/bin/pkill --signal SIGINT wf-recorder
        fi;
      ''
    )

    (
      pkgs.writeShellScriptBin "power-menu" ''
        #!/usr/bin/env bash
        options="shutdown\nreboot\nsuspend"

        selection="$(${pkgs.coreutils}/bin/echo -e $options | \
                     ${pkgs.bemenu}/bin/bemenu -i -l 3 -c -W 0.3)"

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
  ];
}
