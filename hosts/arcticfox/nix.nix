{ inputs }:
{
  registry = {
    # self.flake = self;
    nixpkgs.flake = inputs.nixpkgs;
  };

  extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
  '';

  channel.enable = false;

  settings = {
    nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    auto-optimise-store = true;
  };
}
