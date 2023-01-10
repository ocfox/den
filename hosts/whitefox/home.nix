{ pkgs
, config
, inputs
, ...
}: {
  imports = [
    ../../programs
    ../../services
    ../../scripts
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme;
      name = "Materia";
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    gtk3.extraConfig = {
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
    };
  };
  wayland.windowManager.hyprland.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.nur.repos.ambroisie.vimix-cursors;
    name = "Vimix-white-cursors";
  };

  programs.home-manager.enable = true;

  programs.mako = {
    enable = true;
    backgroundColor = "#2b3339";
    borderSize = 1;
    borderColor = "#83b6af";
    defaultTimeout = 5000;
    font = "JetBrainsMono Nerd Font 12";
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [ obs-studio-plugins.wlrobs ];
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      if test $(id --user $USER) = 1000 && test $(tty) = "/dev/tty1"
      then
        exec sway
      elif test $TERM = "xterm-kitty" || test $TERM = "xterm-256color"
      then
        exec fish
      fi
    '';
  };

  home.packages = with pkgs; [
    # aseprite-unfree
    bitwarden
    waybar
    foot
    wl-clipboard
    swayidle
    showmethekey
    gh

    lolcat
    tree
    element-desktop
    qbittorrent
    tdesktop

    firefox-wayland
    qutebrowser

    factorio-experimental

    # Music & Video
    ncspot
    sptlrx
    playerctl
    cava
    vlc
    wf-recorder

    # Application
    nur.repos.linyinfeng.icalingua-plus-plus
    nur.repos.pokon548.tencent-qq-electron
    screenkey

    julia-bin
    texlive.combined.scheme-medium
  ];
  home.stateVersion = "22.05";
}
