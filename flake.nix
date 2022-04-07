{
  description = "nixos-config";

  inputs.nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  # inputs.dwm.url = "github:ocfox/dwm";
  inputs.polymc.url = "github:PolyMC/PolyMC";
  inputs.nur.url = github:nix-community/NUR;
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self
            , nixpkgs-mozilla
            , nixpkgs
            # , dwm
            , nur
            , home-manager
            , polymc
            , ...}@inputs:
    let
      system = "x86_64-linux";
      username = "ocfox";
    in {

      nixosConfigurations.whitefox =  nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
           home-manager.useGlobalPkgs = true;
           home-manager.useUserPackages = true;
           home-manager.users.ocfox = import ./home.nix;
          }
          { nixpkgs.overlays = [
              nur.overlay
              # dwm.overlay
              nixpkgs-mozilla.overlay
              polymc.overlay
          ]; }
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
