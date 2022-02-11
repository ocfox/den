{
  description = "nixos-config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.nur.url = github:nix-community/NUR;
  # inputs.home-manager = {
  #   url = "github:nix-community/home-manager";
  #   inputs.nixpkgs.follows = "nixpkgs";
  # };

  outputs = { self, nixpkgs, nur, neovim-nightly-overlay, home-manager, ...}@inputs:
    let
      system = "x86_64-linux";
      # overlays = [
      #     inputs.neovim-nightly-overlay.overlay
      #   ];
    in {

      # homeConfigurations.ocfox = home-manager.lib.homeManagerConfiguration {
      #   system = null;
      #   pkgs = self.legacyPackages."x86_64-linux";
      #   stateVersion = "unstable";
      #
      #   homeDirectory = "/home/ocfox";
      #   username = "ocfox";
      #   configuration = { pkgs, ... }:
      #       {
      #         nixpkgs.overlays = overlays;
      #       };
      # };

      nixosConfigurations.whitefox =  nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          { nixpkgs.overlays = [ nur.overlay neovim-nightly-overlay.overlay ]; }
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
