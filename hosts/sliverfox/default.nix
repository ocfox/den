{ username, nixpkgs, darwin, inputs, ... }:
darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  modules = [
    ./configuration.nix
    inputs.home-manager.darwinModules.home-manager
    {
      nixpkgs.config.allowUnfree = true;
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = nixpkgs.lib.mkMerge [
        ./home.nix
      ];
    }
  ];
}
