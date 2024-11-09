{
  username,
  nixpkgs,
  home,
  inputs,
  self,
  ...
}:
let
  genConf =
    host:
    { pkgs, username, ... }@args:
    inputs.haumea.lib.load {
      src = ./${host};
      inputs = args // {
        inherit inputs;
      };
      transformer = inputs.haumea.lib.transformers.liftDefault;
    };

  genNixosSystem = host: system: modules: {
    "${host}" = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        (genConf "${host}")
        (genConf "general")
        inputs.self.nixosModules.default
      ] ++ modules;
      specialArgs = {
        inherit inputs username home;
      };
    };
  };
  inherit (nixpkgs.lib) mkMerge;
in
mkMerge [
  (genNixosSystem "whitefox" "x86_64-linux" [
    ./whitefox/_hardware.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.minegrub.nixosModules.default
    inputs.niri.nixosModules.niri
    inputs.chaotic.nixosModules.default
    { nix.registry.self.flake = self; }
  ])

  (genNixosSystem "bebop" "x86_64-linux" [
    inputs.disko.nixosModules.disko
    inputs.rotix.nixosModules.default
    inputs.nixos-facter.nixosModules.facter
  ])

  (genNixosSystem "civet" "x86_64-linux" [
    inputs.disko.nixosModules.disko
    inputs.nixos-facter.nixosModules.facter
  ])

  (genNixosSystem "redfox" "x86_64-linux" [
    ./redfox/_hardware.nix
    inputs.disko.nixosModules.disko
  ])

  (genNixosSystem "arcticfox" "x86_64-linux" [
    ./arcticfox/_hardware.nix
    inputs.home-manager.nixosModules.home-manager
    { nix.registry.self.flake = self; }
  ])

  (genNixosSystem "vulpes" "x86_64-linux" [
    ./vulpes/_hardware.nix
  ])
]
