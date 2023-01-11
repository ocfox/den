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
    ./fish.nix
    ./git.nix
    ./tmux.nix
  ] ++ (if hostname == "whitefox" then
    [
      ./alacritty.nix
      ./sway.nix
      ./waybar
      ./kitty.nix
    ] else [ ]
  );

  programs = {
    chromium = {
      enable = hostname == "whitefox";
      commandLineArgs = [ "--enable-features=UseOzonePlatform" "-ozone-platform=wayland" "--gtk-version=4" ];
    };
    exa = {
      enable = true;
      enableAliases = true;
    };
    man.enable = true;
  };
}
