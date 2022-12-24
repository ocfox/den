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

  ];
}
