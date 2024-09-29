{
  username,
  nixpkgs,
  home,
  inputs,
  self,
  ...
}:
let
  whitefox-module =
    { pkgs, username, ... }@args:
    inputs.haumea.lib.load {
      src = ./whitefox;
      inputs = args // {
        inherit inputs;
      };
      transformer = inputs.haumea.lib.transformers.liftDefault;
    };

  # silverfox-module =
  #   { pkgs, username, ... }@args:
  #   inputs.haumea.lib.load {
  #     src = ./silverfox;
  #     inputs = args // {
  #       inherit inputs;
  #     };
  #     transformer = inputs.haumea.lib.transformers.liftDefault;
  #   };

  arcticfox-module =
    { pkgs, username, ... }@args:
    inputs.haumea.lib.load {
      src = ./arcticfox;
      inputs = args // {
        inherit inputs;
      };
      transformer = inputs.haumea.lib.transformers.liftDefault;
    };

  redfox-module =
    { pkgs, username, ... }@args:
    inputs.haumea.lib.load {
      src = ./redfox;
      inputs = args // {
        inherit inputs;
      };
      transformer = inputs.haumea.lib.transformers.liftDefault;
    };

  civet-module =
    { pkgs, ... }@args:
    inputs.haumea.lib.load {
      src = ./civet;
      inputs = args // {
        inherit inputs;
      };
      transformer = inputs.haumea.lib.transformers.liftDefault;
    };

  sakhalin-module =
    { pkgs, ... }@args:
    inputs.haumea.lib.load {
      src = ./sakhalin;
      inputs = args // {
        inherit inputs;
      };
      transformer = inputs.haumea.lib.transformers.liftDefault;
    };

  vulpes-module =
    { pkgs, ... }@args:
    inputs.haumea.lib.load {
      src = ./vulpes;
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
      inputs.niri.nixosModules.niri
      inputs.self.nixosModules.default
      { nix.registry.self.flake = self; }
    ];
    specialArgs = {
      inherit inputs username home;
    };
  };

  civet = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      inputs.disko.nixosModules.disko
      inputs.nixos-facter.nixosModules.facter
      civet-module
    ];
    specialArgs = {
      inherit inputs;
    };
  };

  arcticfox = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./arcticfox/_hardware.nix
      arcticfox-module
      inputs.home-manager.nixosModules.home-manager
      inputs.agenix.nixosModules.default
      { nix.registry.self.flake = self; }
    ];
    specialArgs = {
      inherit inputs username home;
    };
  };

  redfox = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./redfox/_hardware.nix
      inputs.disko.nixosModules.disko
      redfox-module
    ];
    specialArgs = {
      inherit inputs;
    };
  };

  sakhalin = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./sakhalin/_hardware.nix
      sakhalin-module
    ];
    specialArgs = {
      inherit inputs;
    };
  };

  vulpes = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./vulpes/_hardware.nix
      vulpes-module
    ];
    specialArgs = {
      inherit inputs;
    };
  };
}
