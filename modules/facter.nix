{ inputs, ... }:
{
  flake.modules.nixos.facter.imports = [
    inputs.nixos-facter.nixosModules.facter
  ];
}
