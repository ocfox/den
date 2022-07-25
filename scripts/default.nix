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
      pkgs.writeShellScriptBin "screen-recorder-toggle" ''
        #!/usr/bin/env bash
        pid=`pgrep wf-recorder`
        status=$?

        if [ $status != 0 ]
        then
          ${pkgs.wf-recorder}/bin/wf-recorder -g "$(${pkgs.slurp}/bin/slurp)" -f $HOME/Videos/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
        else
          pkill --signal SIGINT wf-recorder
        fi;
      ''
    )
  ];
}
