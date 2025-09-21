{ pkgs, ... }:
{
  fontconfig = {
    enable = true;
    antialias = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      sansSerif = [
        "Inter"
        "Sarasa Gothic J"
      ];
      serif = [
        "Sarasa Gothic J"
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
    # vistafonts-chs
    inter
    sarasa-gothic
    lxgw-wenkai
    source-han-serif
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
  ];
}
