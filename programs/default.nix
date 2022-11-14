{ config
, lib
, pkgs
, ...
}: {
  imports = [
    ./waybar
    ./alacritty.nix
    ./fish.nix
    ./kitty.nix
    ./sway.nix
    ./git.nix
  ];

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = [ "--enable-features=UseOzonePlatform" "-ozone-platform=wayland" "--gtk-version=4" ];
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
  };
}
