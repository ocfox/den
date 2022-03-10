{
  description = "nixos-config";

  inputs.nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  # inputs.dwm.url = "github:ocfox/dwm";
  inputs.neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  inputs.nur.url = github:nix-community/NUR;
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs-mozilla, nixpkgs, nur, neovim-nightly-overlay, home-manager, ...}@inputs:
    let
      system = "x86_64-linux";
      username = "ocfox";
      # overlays = [
      #     inputs.neovim-nightly-overlay.overlay
      #   ];
    in {

      # homeConfigurations.ocfox = home-manager.lib.homeManagerConfiguration {
      #   stateVersion = "unstable";
      #
      #   inherit system username;
      #   homeDirectory = "/home/${username}";
      #   configuration = import ./home.nix;
      # };

      nixosConfigurations.whitefox =  nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          { nixpkgs.overlays = [ nur.overlay neovim-nightly-overlay.overlay nixpkgs-mozilla.overlay ]; }
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
