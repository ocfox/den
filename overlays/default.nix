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
    })
  ];
}
