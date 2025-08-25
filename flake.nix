{
  description = "ocfox's flake";

  outputs =
    inputs@{
      self,
      nixpkgs,
      haumea,
      vaultix,
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
        inputs.vaultix.flakeModules.default
      ];

      perSystem =
        {
          lib,
          system,
          pkgs,
          ...
        }:
        {
          packages = lib.packagesFromDirectoryRecursive {
            callPackage = lib.callPackageWith pkgs;
            directory = ./pkgs;
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

        darwinConfigurations.katana = inputs.nix-darwin.lib.darwinSystem {
          modules = [
            {
              home-manager.users.ed = {
                imports = [ home.default ];
              };
            }
            ./katana
            inputs.home-manager.darwinModules.home-manager
          ];
        };

        ferrucyon = import ./iso {
          inherit
            self
            nixpkgs
            inputs
            username
            ;
        };

        vaultix = {
          identity = self + "/secrets/age-yubikey-identity-de5ab175.txt";
          nodes =
            let
              inherit (inputs.nixpkgs.lib) filterAttrs elem;
            in
            filterAttrs (
              n: _:
              !elem n [
                # "chi"
                "whitefox"
                "redfox"
                "vulpes"
              ]
            ) self.nixosConfigurations;
        };

        nixosModules = import ./modules;
      };
    };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    minegrub.url = "github:ocfox/minegrub-world-sel-theme";
    niri.url = "github:sodiboo/niri-flake";
    nixos-facter.url = "github:numtide/nixos-facter-modules";
    vaultix.url = "github:milieuim/vaultix";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
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
