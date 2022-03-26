{
  description = "nixos-config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  # inputs.dwm.url = "github:ocfox/dwm";
  inputs.polymc.url = "github:PolyMC/PolyMC";
  # inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.nur.url = github:nix-community/NUR;
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nur, home-manager, polymc, ...}@inputs:
    let
      system = "x86_64-linux";
      username = "ocfox";
      # overlays = [
      #     inputs.neovim-nightly-overlay.overlay
      #   ];
    in {
      nixosConfigurations.whitefox =  nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          { nixpkgs.overlays = [ nur.overlay polymc.overlay ]; }
          home-manager.nixosModules.home-manager
          {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
           home-manager.users.ocfox = import ./home.nix;
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
