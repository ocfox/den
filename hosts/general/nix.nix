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
    nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
    auto-optimise-store = true;
  };
}
