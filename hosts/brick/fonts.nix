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
        "IPAPGothic"
      ];
      serif = [
        "Roboto Serif"
        "Microsoft YaHei"
        "IPAPMincho"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Sarasa Mono J"
      ];
    };
  };

  fontDir.enable = true;
  enableGhostscriptFonts = true;

  enableDefaultPackages = true;
  packages = with pkgs; [
    vistafonts-chs
    inter
    ipafont
    sarasa-gothic
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];
}
