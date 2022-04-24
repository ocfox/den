{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
      };

      factorio = super.factorio.override {
        username = "ocfox";
        token = "483926ff66c4429ec6084fc0533c17";
      };
    })

    (final: prev: {
      # sha256 = "0000000000000000000000000000000000000000000000000000";
      dwm = prev.dwm.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ final.xorg.libXext ];
        src = pkgs.fetchFromGitHub {
          owner = "ocfox";
          repo = "dwm";
          rev = "265270282811ae390fb29beb91ead4f59efc19ff";
          sha256 = "vifwD6DalgtK76lFLLr188lFB1TRsdxrBlxhfBlHsVQ=";
        };
      });

      picom = prev.picom.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "Arian8j2";
          repo = "picom-jonaburg-fix";
          rev = "31d25da22b44f37cbb9be49fe5c239ef8d00df12";
          sha256 = "1z4bKDoNgmG40y2DKTSSh1NCafrE1rkHkCB3ob8ibm4=";
        };
      });

      dmenu = prev.dmenu.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "ocfox";
          repo = "dmenu";
          rev = "967c1844df79bea0d8eaf0a981bd03b1ae5f5fa3";
          sha256 = "Bf6VEV+xWG+gr9raTeLnf0p4yB/WP6bHFYwQeq69XqY=";
        };
      });
    })

  ];
}
