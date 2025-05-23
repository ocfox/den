{ inputs }:
{
  registry = {
    nixpkgs.flake = inputs.nixpkgs;
  };

  extraOptions = ''
    experimental-features = nix-command flakes ca-derivations
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
    substituters = [
      "https://cache.garnix.io"
    ];
    trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
    nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
    auto-optimise-store = true;
  };
}
