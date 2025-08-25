{ pkgs, ... }:
{
  fontconfig = {
    enable = true;
    antialias = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      sansSerif = [
        "Inter"
        "Microsoft YaHei"
      ];
      serif = [
        "Roboto Serif"
        "Microsoft YaHei"
      ];
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };

  fontDir.enable = true;
  enableGhostscriptFonts = true;

  enableDefaultPackages = true;
  packages = with pkgs; [
    vistafonts-chs
    inter
    roboto
    roboto-serif
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];
}
