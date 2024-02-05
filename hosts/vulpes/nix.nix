{ inputs }:
{
  registry = {
    nixpkgs.flake = inputs.nixpkgs;
  };

  extraOptions = ''
    experimental-features = nix-command flakes
  '';

  channel.enable = false;

  settings = {
    nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
    auto-optimise-store = true;
  };
}
