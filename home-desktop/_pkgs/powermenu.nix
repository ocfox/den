{ lib
, pkgs
}:
pkgs.writeShellScriptBin "powermenu" ''
  options="shutdown\nreboot\nsuspend"

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
  esac
''
