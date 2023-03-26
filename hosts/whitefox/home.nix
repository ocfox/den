{ pkgs
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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.pointerCursor = {
    size = 24;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.apple-cursor;
    name = "macOS-Monterey";
  };

  programs.home-manager.enable = true;

  services.mako = {
    enable = true;
    backgroundColor = "#2b333900";
    borderSize = 0;
    borderColor = "#83b6af00";
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
        exec Hyprland
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

    # factorio-experimental

    ncspot
    sptlrx
    playerctl
    cava
    vlc
    wf-recorder

    # Application
    nur.repos.linyinfeng.wemeet
    nur.repos.linyinfeng.icalingua-plus-plus
    nur.repos.pokon548.tencent-qq-electron

    texlive.combined.scheme-medium
  ];
  home.stateVersion = "22.05";
}
