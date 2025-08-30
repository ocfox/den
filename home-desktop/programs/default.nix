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

  fuzzel = {
    enable = true;
    settings.main.launch-prefix = "env DISPLAY=:77";
  };
}
