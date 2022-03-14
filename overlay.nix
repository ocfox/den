{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
     neovim = super.neovim.override {
       viAlias = true;
       vimAlias = true;
     };
    })

    (final: prev: {
            # sha256 = "0000000000000000000000000000000000000000000000000000";
      dwm = prev.dwm.overrideAttrs (old: {
          buildInputs = (old.buildInputs or []) ++ [ final.xorg.libXext ];
          src = pkgs.fetchFromGitHub {
            owner = "ocfox";
            repo = "dwm";
            rev = "3cd0aa7543eaee4df4818eab3f473e554ccedf16";
            sha256 = "nlXg4szkOYTtwk/HqE4Wc/eEI4M2zKwCHBuE01tVy+0=";
          };});
      # picom = prev.picom.overrideAttrs (old: {
      #     src = pkgs.fetchFromGitHub {
      #       owner = "jonaburg";
      #       repo = "picom";
      #       rev = "a8445684fe18946604848efb73ace9457b29bf80";
      #       sha256 = "R+YUGBrLst6CpUgG9VCwaZ+LiBSDWTp0TLt1Ou4xmpQ=";
      #     };});

      picom = prev.picom.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "yshui";
            repo = "picom";
            rev = "aa316aa3601a4f3ce9c1ca79932218ab574e61a7";
            sha256 = "Yb69LTu45HxBWoD/T9Uj6b1lNn7hHzIEjcn73PMMEz0=";
          };});

      dmenu = prev.dmenu.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "ocfox";
            repo = "dmenu";
            rev = "967c1844df79bea0d8eaf0a981bd03b1ae5f5fa3";
            sha256 = "Bf6VEV+xWG+gr9raTeLnf0p4yB/WP6bHFYwQeq69XqY=";
          } ;});
    })

  ];
}
