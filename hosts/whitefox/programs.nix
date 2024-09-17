{ pkgs }:
{
  adb.enable = true;
  git.enable = true;
  nm-applet.enable = true;
  dconf.enable = true;

  niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  ssh.startAgent = true;
  sway.enable = true;
  fish = {
    useBabelfish = true;
    enable = true;
  };
}
