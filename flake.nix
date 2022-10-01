{
  description = "nixos-config";

  outputs =
    { self
    , nixpkgs
    , nur
    , home-manager
    , grub2-themes
    , darwin
    , ...
    } @ inputs:
    let
      username = "ocfox";
    in
    {
      nixosConfigurations.whitefox = import ./hosts/whitefox {
        inherit self nixpkgs inputs username;
      };

      darwinConfigurations.sliverfox = import ./hosts/sliverfox {
        inherit self nixpkgs darwin inputs username;
      };
    };

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    grub2-themes.url = github:vinceliuice/grub2-themes;
    nur.url = github:nix-community/NUR;
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
