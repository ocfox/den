{
  description = "ocfox's flake";

  outputs =
    { self
    , nixpkgs
    , haumea
    , ...
    }@inputs:
    let
      username = "ocfox";
      home = {
        default = { pkgs, ... }@args: haumea.lib.load {
          src = ./home;
          inputs = args // {
            inherit inputs;
          };
          transformer = haumea.lib.transformers.liftDefault;
        };
        desktop = { pkgs, ... }@args: haumea.lib.load {
          src = ./home-desktop;
          inputs = args // {
            inherit inputs;
          };
          transformer = haumea.lib.transformers.liftDefault;
        };
      };
    in
    {
      nixosConfigurations = import ./hosts {
        inherit self nixpkgs inputs username home;
      };

      ferrucyon = import ./iso {
        inherit self nixpkgs inputs username;
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    minegrub.url = "github:ocfox/minegrub-theme";
    agenix.url = "github:ryantm/agenix";
    factorio-versions.url = "github:ocfox/factorio-versions";
    nur.url = "github:nix-community/NUR";
    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    bin = {
      url = "github:w4/bin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
