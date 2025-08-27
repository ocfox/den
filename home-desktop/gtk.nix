{ pkgs }:
{
  enable = true;
  theme = {
    name = "Adwaita-dark";
    package = pkgs.gnome-themes-extra;
  };
  iconTheme = {
    name = "Numix-Circle";
    package = pkgs.numix-icon-theme-circle;
  };
  gtk3.extraConfig = {
    gtk-xft-hinting = 1;
    gtk-xft-hintstyle = "hintslight";
  };
}
