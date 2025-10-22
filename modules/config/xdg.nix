{
  flake.modules.nixos.xdg =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = [
        pkgs.local.mpv-handler
        pkgs.nautilus
        pkgs.sioyek
      ];
      xdg = {
        mime = {
          enable = true;
          defaultApplications = {
            "application/x-xdg-protocol-tg" = [ "org.telegram.desktop.desktop" ];
            "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
            "x-scheme-handler/mpv" = [ "mpv-handler.desktop" ];
            "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
            "application/pdf" = [ "sioyek.desktop" ];
          }
          // lib.genAttrs [
            "x-scheme-handler/unknown"
            "x-scheme-handler/about"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/mailto"
            "text/html"
          ] (_: "firefox.desktop");
        };
        portal = {
          enable = true;
          wlr.enable = true;
          config.common.default = "wlr";
        };
      };
    };
}
