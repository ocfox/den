{ self
, username
, nixpkgs
, inputs
, ...
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.grub2-themes.nixosModules.default
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = {
        imports = [
          ./home.nix
          inputs.hyprland.homeManagerModules.default
        ];
      };
      home-manager.extraSpecialArgs = { inherit username; };
    }
    {
      nixpkgs.overlays = [
        inputs.nur.overlay
      ];
      nix.settings.nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
      nix.registry = {
        self.flake = self;
        nixpkgs.flake = inputs.nixpkgs;
      };
    }
  ];
  specialArgs = { inherit inputs username; };
}
