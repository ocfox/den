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
    ./tmux.nix
  ];

  home-manager.users.ocfox.programs = {

    doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom.d;
    };

    chromium = {
      enable = true;
      commandLineArgs = ["--enable-features=UseOzonePlatform" "-ozone-platform=wayland" "--gtk-version=4"];
    };
    waybar = {
      enable = true;
      settings = [(import ./waybar.nix {inherit pkgs;})];
      style = builtins.readFile ./waybar.css;
      systemd.enable = true;
    };
  };
}
