{ inputs, ... }:
{
  imports = [ inputs.vaultix.flakeModules.default ];
  flake = {
    vaultix = {
      identity = inputs.self + "/secrets/age-yubikey-identity-de5ab175.txt";
      nodes = inputs.self.nixosConfigurations;
    };
  };
}
