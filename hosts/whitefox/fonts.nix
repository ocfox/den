{ pkgs, ... }: {
  fonts = {
    enableDefaultFonts = true;
    # see https://github.com/NixOS/nixpkgs/pull/222236
    # optimizeForVeryHighDPI = true;
    fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        sansSerif = [ "DejaVu Sans" ];
        serif = [ "DejaVu Serif" ];
      };
    };

    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
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
  };
}
