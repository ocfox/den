{
  description = "nixos-config";

  outputs =
    { self
    , nixpkgs
    , nur
    , home-manager
    , grub2-themes
    , darwin
    , ...
    } @ inputs:
    let
      username = "ocfox";
    in
    {
      nixosConfigurations.whitefox = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/whitefox/configuration.nix
          home-manager.nixosModules.home-manager
          grub2-themes.nixosModule
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = nixpkgs.lib.mkMerge [
              ./hosts/whitefox/home.nix
            ];
          }
          {
            nixpkgs.overlays = [
              nur.overlay
            ];
          }
        ];
        specialArgs = { inherit inputs; };
      };

      darwinConfigurations.sliverfox = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/sliverfox/configuration.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = nixpkgs.lib.mkMerge [
              ./hosts/sliverfox/home.nix
            ];
          }
        ];
      };
    };

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    grub2-themes.url = github:vinceliuice/grub2-themes;
    nur.url = github:nix-community/NUR;
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
