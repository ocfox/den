{ pkgs, ... }:
{
  fontconfig = {
    enable = true;
    antialias = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      sansSerif = [ "Inter" ];
      serif = [ "Roboto Serif" ];
      monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };

  fontDir.enable = true;
  enableGhostscriptFonts = true;

  enableDefaultPackages = true;
  packages = with pkgs; [
    inter
    roboto
    roboto-serif
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Hack"
        "DroidSansMono"
        "JetBrainsMono"
        "FantasqueSansMono"
      ];
    })
  ];
}
