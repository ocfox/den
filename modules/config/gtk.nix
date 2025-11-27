{
  flake.modules.nixos.gtk = { lib, pkgs, config, ... }:
  let
    # For GTK3 and GTK4
    settingsIniContent = lib.generators.toINI {} {
      Settings = {
        gtk-theme-name = "Adwaita-dark";
        gtk-icon-theme-name = "Numix-Circle";
        gtk-cursor-theme-name = "macOS";
        gtk-cursor-theme-size = 24;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
      };
    };

    # GTK2 has a slightly different format (no [Settings] header)
    gtk2Content = ''
      gtk-theme-name = "Adwaita-dark"
      gtk-icon-theme-name = "Numix-Circle"
      gtk-cursor-theme-name = "macOS"
      gtk-cursor-theme-size = 24
    '';
  in
  {
    # Add theme packages to make them available to the system
    my.packages = [
      pkgs.gnome-themes-extra
      pkgs.numix-icon-theme-circle
      pkgs.apple-cursor
    ];

    # Place the config files using our declarative system
    my.config = {
      "gtk-3.0" = {
        "settings.ini" = pkgs.writeText "gtk3-settings.ini" settingsIniContent;
      };
      "gtk-4.0" = {
        "settings.ini" = pkgs.writeText "gtk4-settings.ini" settingsIniContent;
      };
      "gtk-2.0" = {
        "gtkrc" = pkgs.writeText "gtkrc-2.0" gtk2Content;
      };
    };
  };
}
