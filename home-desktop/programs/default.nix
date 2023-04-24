{ pkgs }:
{
  chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "-ozone-platform=wayland"
      "--gtk-version=4"
    ];
  };
  obs-studio = {
    enable = true;
    plugins = with pkgs; [ obs-studio-plugins.wlrobs ];
  };
}
