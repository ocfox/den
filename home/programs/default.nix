{ pkgs }:
{
  chromium = {
    enable = true;
    commandLineArgs = [ "--enable-features=UseOzonePlatform" "-ozone-platform=wayland" "--gtk-version=4" ];
  };
  exa = {
    enable = true;
    enableAliases = true;
  };
  direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home-manager.enable = true;

  obs-studio = {
    enable = true;
    plugins = with pkgs; [ obs-studio-plugins.wlrobs ];
  };

  bash.enable = true;

  man.enable = true;
}
