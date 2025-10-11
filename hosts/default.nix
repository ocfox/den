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
        inputs.determinate.nixosModules.default
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
    # inputs.vaultix.nixosModules.default
    inputs.niri.nixosModules.niri
    { nix.registry.self.flake = self; }
  ])

  (genNixosSystem "brick" "x86_64-linux" [
    ./brick/_hardware.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
    inputs.chaotic.nixosModules.default
    { nix.registry.self.flake = self; }
  ])

  # (genNixosSystem "bebop" "x86_64-linux" [
  #   inputs.disko.nixosModules.disko
  #   inputs.nixos-facter.nixosModules.facter
  # ])

  (genNixosSystem "chi" "aarch64-linux" [
    inputs.vaultix.nixosModules.default
    inputs.disko.nixosModules.disko
    inputs.nixos-facter.nixosModules.facter
  ])

  (genNixosSystem "redfox" "x86_64-linux" [
    ./redfox/_hardware.nix
    inputs.disko.nixosModules.disko
  ])

  (genNixosSystem "vulpes" "x86_64-linux" [
    ./vulpes/_hardware.nix
  ])
]
