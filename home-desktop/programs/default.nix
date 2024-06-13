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
}
