{ username
, darwin
, inputs
, home
, ...
}:
let
  silverfox = { pkgs, username, ... }@args: inputs.haumea.lib.load {
    src = ./silverfox;
    inputs = args // {
      inherit inputs;
    };
    transformer = inputs.haumea.lib.transformers.liftDefault;
  };
in
darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  modules = [
    silverfox
    inputs.home-manager.darwinModules.home-manager
  ];
  specialArgs = { inherit inputs username home; };
}
