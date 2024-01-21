{ username
, nixpkgs
, home
, inputs
, self
, ...
}:
let
  whitefox-module = { pkgs, username, ... }@args: inputs.haumea.lib.load {
    src = ./whitefox;
    inputs = args // {
      inherit inputs;
    };
    transformer = inputs.haumea.lib.transformers.liftDefault;
  };
  arcticfox-module = { pkgs, username, ... }@args: inputs.haumea.lib.load {
    src = ./arcticfox;
    inputs = args // {
      inherit inputs;
    };
    transformer = inputs.haumea.lib.transformers.liftDefault;
  };

  redfox-module = { pkgs, username, ... }@args: inputs.haumea.lib.load {
    src = ./redfox;
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
      whitefox-module
      inputs.home-manager.nixosModules.home-manager
      inputs.minegrub.nixosModules.default
      inputs.agenix.nixosModules.default
      {
        nix.registry.self.flake = self;
      }
    ];
    specialArgs = { inherit inputs username home; };
  };

  arcticfox = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./arcticfox/_hardware.nix
      arcticfox-module
      inputs.home-manager.nixosModules.home-manager
      {
        nix.registry.self.flake = self;
      }
    ];
    specialArgs = { inherit inputs username home; };
  };

  redfox = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./redfox/_hardware.nix
      inputs.bin.nixosModules.default
      redfox-module
    ];
    specialArgs = { inherit inputs username home; };
  };
}
