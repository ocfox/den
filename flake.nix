{
  description = "nixos-config";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nur.url = github:nix-community/NUR;
  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nur-pkgs = {
    url = "github:ocfox/nur-pkgs";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nur,
    home-manager,
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
          ];
        }
      ];
      specialArgs = {inherit inputs;};
    };
  };
}
