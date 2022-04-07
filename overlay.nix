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
              buildInputs = (old.buildInputs or []) ++ [ final.xorg.libXext ];
              src = pkgs.fetchFromGitHub {
              owner = "ocfox";
              repo = "dwm";
              rev = "4320f2d7a610ae85cb1a630bc0713800e262e5be";
              sha256 = "4745EhooIQ422rQnixtMXfjw5cxUPjoSdScJPskl1IU=";
          };});

      picom = prev.picom.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "Arian8j2";
            repo = "picom-jonaburg-fix";
            rev = "31d25da22b44f37cbb9be49fe5c239ef8d00df12";
            sha256 = "1z4bKDoNgmG40y2DKTSSh1NCafrE1rkHkCB3ob8ibm4=";
          };});

      # picom = prev.picom.overrideAttrs (old: {
      #     src = pkgs.fetchFromGitHub {
      #       owner = "ibhagwan";
      #       repo = "picom";
      #       rev = "c4107bb6cc17773fdc6c48bb2e475ef957513c7a";
      #       sha256 = "1hVFBGo4Ieke2T9PqMur1w4D0bz/L3FAvfujY9Zergw=";
      #     };});

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
