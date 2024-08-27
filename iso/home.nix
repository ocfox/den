{ pkgs, ... }:
{
  imports = [ ../programs ];

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

  home.pointerCursor = {
    size = 24;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.apple-cursor;
    name = "macOS-Monterey";
  };

  programs.home-manager.enable = true;

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
    firefox
    wget
    curl
    bind
    htop
    bat
    unzip
    file
    zip
    git
    hwdata
    acpi
    pciutils
    btrfs-progs
    smartmontools
    ripgrep
  ];
  home.stateVersion = "23.05";
}
