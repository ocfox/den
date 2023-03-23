{ lib
, pkgs
, config
, ...
}:
{
  programs.waybar = {
    enable = true;
    settings = [ (import ./waybar.nix { inherit lib pkgs; }) ];
    style = builtins.readFile ./waybar.css;
    systemd.enable = true;
  };
}
