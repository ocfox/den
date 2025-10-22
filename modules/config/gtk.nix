{
  flake.modules.homeManager.gtk =
    { pkgs, ... }:
    {
      gtk = {
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
      };

      home.pointerCursor = {
        size = 24;
        gtk.enable = true;
        package = pkgs.apple-cursor;
        name = "macOS";
      };
    };
}
