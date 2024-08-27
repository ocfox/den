{
  self,
  username,
  nixpkgs,
  inputs,
  ...
}:
let
  ferrucyon = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./configuration.nix
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${username} = {
          imports = [
            ./home.nix
            inputs.hyprland.homeManagerModules.default
          ];
        };
        home-manager.extraSpecialArgs = {
          inherit username;
        };
      }
      {
        nix.settings.nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
        nix.registry = {
          self.flake = self;
          nixpkgs.flake = inputs.nixpkgs;
        };
      }
    ];
    specialArgs = {
      inherit inputs username;
    };
  };
in
ferrucyon.config.system.build.isoImage
