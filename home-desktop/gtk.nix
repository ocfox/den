{ pkgs }:
{
  enable = true;
  theme = {
    package = pkgs.numix-gtk-theme;
    name = "Numix";
  };
  iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Dark";
  };
  gtk3.extraConfig = {
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintslight";
  };
}
