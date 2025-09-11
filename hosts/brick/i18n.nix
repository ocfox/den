{ pkgs }:
{
  defaultLocale = "en_US.UTF-8";
  extraLocales = "all";
  inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-mozc
      fcitx5-configtool
    ];
  };
}
