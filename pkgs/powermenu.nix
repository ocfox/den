{ lib, pkgs }:
pkgs.writeShellScriptBin "powermenu" ''
  echo -e "  Poweroff\n  Reboot\n  Suspend\n  Hibernate" | \
    ${lib.getExe pkgs.fuzzel} -d | \
    case "$(cat -)" in
      *Poweroff)
        systemctl poweroff ;;
      *Reboot)
        systemctl reboot ;;
      *Suspend)
        systemctl suspend ;;
      *Hibernate)
        systemctl hibernate ;;
    esac
''
