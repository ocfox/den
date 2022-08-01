{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./fish.nix
    ./kitty.nix
    ./nnn.nix
    ./sway.nix
    # ./hyprland.nix
  ];

  home-manager.users.ocfox.programs.waybar = {
    enable = true;
    settings = [(import ./waybar.nix {inherit pkgs;})];
    style = builtins.readFile ./waybar.css;
    systemd.enable = true;
  };
}
