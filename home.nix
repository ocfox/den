{pkgs, ...}: {
  imports = [
    # ./programs
    #./nvim
    ./services
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme;
      name = "Materia";
    };

    iconTheme = {
      package = pkgs.numix-icon-theme-circle;
      name = "Numix-Circle";
    };
  };

  wayland.windowManager.sway = {
    enable = true;

    wrapperFeatures.gtk = true;

    config = {
      modifier = "Mod4";
      startup = [
        {command = "firefox-devedition";}
        {command = "kotatogram-desktop";}
        # { command = "thunderbird"; }
      ];
      gaps = {
        inner = 5;
        outer = 5;
        smartGaps = true;
      };
    };
  };

  xsession.enable = true;

  services.pasystray.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.nur.repos.ambroisie.vimix-cursors;
    name = "Vimix-white-cursors";
    size = 42;
  };

  programs.home-manager.enable = true;
  # programs.waybar.enable = true;

  home.packages = with pkgs; [
    # aseprite-unfree
    bitwarden
    anbox
    waybar

    # calibre
    lapce
    lolcat
    tree
    element-desktop
    qbittorrent
    kotatogram-desktop
    tdesktop

    # firefox
    firefox-devedition-bin

    # Game
    polymc

    # factorio
    tetrio-desktop

    # Music & Video
    spotify
    spotify-tui
    spotifyd
    sptlrx
    playerctl
    cava
    vlc
    obs-studio

    # Application
    nur.repos.linyinfeng.icalingua-plus-plus
    nur.repos.linyinfeng.wemeet
    discord
    screenkey
    # vimPlugins.markdown-preview-nvim

    #dev
    julia-bin
    texlive.combined.scheme-medium
  ];
  home.stateVersion = "22.05";
}
