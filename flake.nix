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
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "git+file:///home/ocfox/dev/nixpkgs";
    minegrub.url = "github:ocfox/minegrub-theme";
    agenix.url = "github:ryantm/agenix";
    factorio-versions.url = "github:ocfox/factorio-versions";
    bin.url = "github:ocfox/bin";
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
