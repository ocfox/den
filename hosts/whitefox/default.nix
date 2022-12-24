{ username, nixpkgs, inputs, ... }:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.grub2-themes.nixosModule
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = import ./home.nix;
      home-manager.extraSpecialArgs = { inherit username; };
    }
    {
      nixpkgs.overlays = [
        inputs.nur.overlay
      ];
    }
  ];
  specialArgs = { inherit inputs username; };
}
