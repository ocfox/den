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

  gc = {
    automatic = true;
    options = "--delete-older-than 30d";
    dates = "Sun 14:00";
  };

  settings = {
    trusted-users = [
      "root"
      "ocfox"
    ];
    nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
    substituters = [
      "https://cache.nixos.org/"
      "https://nix-community.cachix.org"
      "https://cache.garnix.io"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
    auto-optimise-store = true;
  };
}
