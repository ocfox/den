{
  description = "ocfox's flake";

  outputs =
    inputs@{
      self,
      nixpkgs,
      haumea,
      flake-parts,
      ...
    }:
    let
      username = "ocfox";
      home = {
        default =
          { pkgs, ... }@args:
          haumea.lib.load {
            src = ./home;
            inputs = args // {
              inherit inputs;
            };
            transformer = haumea.lib.transformers.liftDefault;
          };
        desktop =
          { pkgs, ... }@args:
          haumea.lib.load {
            src = ./home-desktop;
            inputs = args // {
              inherit inputs;
            };
            transformer = haumea.lib.transformers.liftDefault;
          };
      };

    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      imports = [
        ./blog
      ];

      perSystem =
        {
          lib,
          system,
          pkgs,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
            ];
          };
        };

      flake = {
        overlays.default =
          final: prev:
          prev.lib.packagesFromDirectoryRecursive {
            inherit (prev) callPackage;
            directory = ./pkgs;
          };

        nixosConfigurations = import ./hosts {
          inherit
            self
            nixpkgs
            inputs
            username
            home
            ;
        };

        ferrucyon = import ./iso {
          inherit
            self
            nixpkgs
            inputs
            username
            ;
        };
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    minegrub.url = "github:ocfox/minegrub-world-sel-theme";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    agenix.url = "github:ryantm/agenix";
    factorio-versions.url = "github:ocfox/factorio-versions";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    papermod = {
      url = "github:adityatelange/hugo-papermod";
      flake = false;
    };
    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
