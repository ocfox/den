{ pkgs }:
{
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
}
