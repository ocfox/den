{ pkgs }:
pkgs.writeShellScriptBin "record-status" ''
  pid=`${pkgs.procps}/bin/pgrep wf-recorder`
  status=$?

  if [ $status != 0 ]
  then
    echo '';
  else
    echo '';
  fi;
''
