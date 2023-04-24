{
  description = "ocfox's flake";

  outputs =
    { self
    , nixpkgs
    , darwin
    , haumea
    , ...
    } @ inputs:
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
        darwin = { pkgs, ... }@args: haumea.lib.load {
          src = ./home-darwin;
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

      darwinConfigurations.silverfox = import ./darwin {
        inherit self nixpkgs darwin inputs username home;
      };

      ferrucyon = import ./iso {
        inherit self nixpkgs inputs username;
      };
    };


  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    nur.url = "github:nix-community/NUR";
    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
