{ lib, pkgs, ... }:
{
  enable = false;
  font = {
    name = "JetBrainsMono Nerd Font";
  };

  settings = {
    background_opacity = "0.9";
    confirm_os_window_close = "0";
    shell = "${lib.getExe pkgs.fish}";
  };

  keybindings = {
    "cmd+t" = "new_tab";
    "cmd+j" = "next_tab";
    "cmd+k" = "previous_tab";
    "cmd+w" = "close_tab";
  };

  extraConfig = ''
    remember_window_size  no
    background  #2b3339
    foreground  #d8caac

    cursor                #d8caac

    selection_foreground  #d8caac
    selection_background  #505a60

    color0  #3c474d
    color8  #868d80

    # red
    color1                #e68183
    # light red
    color9                #e68183

    # green
    color2                #a7c080
    # light green
    color10               #a7c080

    # yellow
    color3                #d9bb80
    # light yellow
    color11               #d9bb80

    # blue
    color4                #83b6af
    # light blue
    color12               #83b6af

    # magenta
    color5                #d39bb6
    # light magenta
    color13               #d39bb6

    # cyan
    color6                #87c095
    # light cyan
    color14               #87c095

    # light gray
    color7                #868d80
    # dark gray
    color15               #868d80
  '';
}
