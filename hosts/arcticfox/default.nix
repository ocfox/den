{ username, nixpkgs, inputs, ... }:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    inputs.home-manager.nixosModules.home-manager
    {
      nixpkgs.config.allowUnfree = true;
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = import ./home.nix;
      home-manager.extraSpecialArgs = { inherit username; };
    }
  ];
  specialArgs = { inherit inputs username; };
}
