{
  description = "nixos-config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.polymc.url = "github:PolyMC/PolyMC";
  inputs.nur.url = github:nix-community/NUR;
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nur-pkgs = {
    url = "github:ocfox/nur-pkgs";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.hyprland = {
    url = "github:hyprwm/Hyprland";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nur,
    home-manager,
    polymc,
    hyprland,
    nur-pkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "ocfox";
  in {
    nixosConfigurations.whitefox = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        hyprland.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = import ./home.nix;
        }
        {
          nixpkgs.overlays = [
            (final: prev: {
              nur-pkgs = inputs.nur-pkgs.packages."${prev.system}";
            })
            nur.overlay
            polymc.overlay
          ];
        }
      ];
      specialArgs = {inherit inputs;};
    };
  };
}
