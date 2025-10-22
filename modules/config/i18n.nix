{
  flake.modules.nixos.i18n = {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocales = "all";
    };
  };

  flake.modules.nixos.fcitx =
    { pkgs, ... }:
    {
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-chinese-addons
          fcitx5-mozc
          fcitx5-configtool
        ];
      };
    };

  flake.modules.nixos.fonts =
    { pkgs, ... }:
    {
      fonts = {
        fontDir.enable = true;
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

        packages = with pkgs; [
          inter
          sarasa-gothic
          source-han-serif
          noto-fonts-emoji
          nerd-fonts.jetbrains-mono
        ];
      };
    };
}
