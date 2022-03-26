{ config, lib, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 19;
    };
    theme = "kanagawabones";
    settings = {
      background_opacity = "0.85";
    };

    keybindings = {
      "cmd+t" = "new_tab";
      "cmd+j" = "next_tab";
      "cmd+k" = "previous_tab";
      "cmd+w" = "close_tab";
    };
  };
}
