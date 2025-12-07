{
  description = "ocfox's flake";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake {
      inherit inputs;
    } (inputs.import-tree ./modules);

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # vaultix.url = "github:milieuim/vaultix";
    vaultix.url = "github:ocfox/vaultix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    nixos-facter.url = "github:numtide/nixos-facter-modules";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
