{ config
, nixosConfig
, lib
, pkgs
, ...
}:
let
  hostname = nixosConfig.networking.hostName;
in
{
  imports = [
    ./alacritty.nix
    ./fish.nix
    ./git.nix
  ] ++ (if hostname == "whitefox" then
    [
      ./sway.nix
      ./waybar
      ./kitty.nix
    ] else [ ]
  );

  programs = {
    chromium = {
      enable = true;
      commandLineArgs = [ "--enable-features=UseOzonePlatform" "-ozone-platform=wayland" "--gtk-version=4" ];
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
    man.enable = true;
  };
}
