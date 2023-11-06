{ pkgs
, ...
}: {
  fontconfig = {
    enable = true;
    antialias = true;
    defaultFonts = {
      emoji = [ "Noto Color Emoji" ];
      sansSerif = [ "DejaVu Sans" ];
      serif = [ "DejaVu Serif" ];
    };
  };

  fontDir.enable = true;
  enableGhostscriptFonts = true;

  enableDefaultPackages = true;
  packages = with pkgs; [
    sarasa-gothic
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    symbola
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
