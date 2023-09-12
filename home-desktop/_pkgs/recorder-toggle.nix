{ lib
, pkgs
}:
pkgs.writeShellScriptBin "screen-recorder-toggle" ''
  pid=`${pkgs.procps}/bin/pgrep wf-recorder`
  status=$?

  if [ $status != 0 ]
  then
    ${lib.getExe' pkgs.wf-recorder "wf-recorder"} -g "$(${lib.getExe pkgs.slurp})" -f $HOME/Videos/record/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
  else
    ${pkgs.procps}/bin/pkill --signal SIGINT wf-recorder
  fi;
''
