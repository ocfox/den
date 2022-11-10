{ pkgs, ... }: {
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

      sway-unwrapped = super.sway-unwrapped.overrideAttrs (old: {
        patches =
          (old.patches or [ ])
          ++ [
            (super.fetchpatch {
              url = "https://github.com/swaywm/sway/commit/9debeb40ceaeae9e577bddcc248a36d99f0a066f.patch";
              sha256 = "sha256-WRB6PuENMnMJV/cUrWLGoi7Aw+wuGi1GaFITJkqB69k=";
            })
          ];
      });
    })

    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ final.xorg.libXext ];
        src = pkgs.fetchFromGitHub {
          owner = "ocfox";
          repo = "dwm";
          rev = "6955b228e2742d903c8dbf0dde6d4c8d6c79d398";
          sha256 = "7bJu+P/XX/xol+ClryGlK5GfBGE5y7+C+lTOwWGfxlw=";
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
