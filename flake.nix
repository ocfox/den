{
  description = "ocfox's nixos-config";

  outputs =
    { self
    , nixpkgs
    , darwin
    , flake-utils
    , ...
    } @ inputs:
    flake-utils.lib.eachDefaultSystem
      (system:
      let
        username = "ocfox";
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        nixosConfigurations.whitefox = import ./hosts/whitefox {
          inherit self nixpkgs inputs username;
        };

        nixosConfigurations.arcticfox = import ./hosts/arcticfox {
          inherit self nixpkgs inputs username;
        };

        darwinConfigurations.sliverfox = import ./hosts/sliverfox {
          inherit self nixpkgs darwin inputs username;
        };

        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            nil
          ];
        };
      });

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    nur.url = "github:nix-community/NUR";
    hyprland.url = "github:hyprwm/Hyprland";
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
