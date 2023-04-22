{ username
, nixpkgs
, home-manager
, inputs
, ...
}:
let
  module = { pkgs, username, ... }@args: inputs.haumea.lib.load {
    src = ./whitefox;
    inputs = args // {
      inherit inputs;
    };
    transformer = inputs.haumea.lib.transformers.liftDefault;
  };
in
{
  whitefox = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ./whitefox/_hardware.nix
      module
      inputs.home-manager.nixosModules.home-manager
      inputs.grub2-themes.nixosModules.default
    ];
    specialArgs = { inherit inputs username home-manager; };
  };
}
