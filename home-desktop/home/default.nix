{ pkgs }:
{
  pointerCursor = {
    size = 24;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.apple-cursor;
    name = "macOS-Monterey";
  };

  stateVersion = "23.05";
}
