{ inputs, ... }:
{
  flake.modules.nixos.nix =
    { pkgs, config, ... }:
    {
      nix = {
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
          trusted-users = [ config.my.name ];
          warn-dirty = false;

          substituters = [
            "https://cache.nixos.org"
            "https://oc.cachix.org"
          ];
          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "oc.cachix.org-1:HlK6/yxAithjAXT2xEPSuegWxgQwtlDPM3twEVcAdco="
          ];

          nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
          auto-optimise-store = true;
        };
      };
    };
}
