{ pkgs }:
{
  adb.enable = true;
  git.enable = true;
  nm-applet.enable = true;
  dconf.enable = true;

  ssh.startAgent = true;

  steam.enable = true;

  # niri = {
  #   enable = true;
  #   package = pkgs.niri-unstable;
  # };

  obs-studio = {
    enable = true;
  };

  sway.enable = true;
  sway.package = pkgs.sway_git;

  fish = {
    useBabelfish = true;
    enable = true;
  };
}
