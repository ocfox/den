{ config
, pkgs
, lib
, ...
}:
{
  imports = [
    ../../programs
  ];
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  home.packages = with pkgs; [
    coreutils
    git
    curl
    wget
    neovim
    ripgrep

    lazygit

    haskellPackages.cabal-install
    haskellPackages.hoogle
    haskellPackages.hpack
    haskellPackages.implicit-hie
    haskellPackages.stack
    jq
  ];

  home.stateVersion = "22.05";
}
