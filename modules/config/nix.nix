{ inputs, ... }:
{
  flake.modules.nixos.nix =
    { pkgs, ... }:
    {
      nix = {
        package = inputs.nix.packages.${pkgs.system}.default;
        registry = {
          nixpkgs.flake = inputs.nixpkgs;
        };

        extraOptions = ''
          experimental-features = nix-command flakes
          lazy-trees = true
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
          trusted-substituters = [ "https://cache.garnix.io" ];
          trusted-public-keys = [ "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
          nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
          auto-optimise-store = true;
        };
      };
    };
}
