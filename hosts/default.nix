{ username
, nixpkgs
, home
, inputs
, self
, ...
}:
let
  module = { pkgs, username, ... }@args: inputs.haumea.lib.load {
    src = ./whitefox;
    inputs = args // {
      inherit inputs;
    };
    transformer = inputs.haumea.lib.transformers.liftDefault;
  };
in
{
  whitefox = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./whitefox/_hardware.nix
      module
      inputs.home-manager.nixosModules.home-manager
      inputs.minegrub.nixosModules.default
      {
        nix.registry.self.flake = self;
      }
    ];
    specialArgs = { inherit inputs username home; };
  };
}
