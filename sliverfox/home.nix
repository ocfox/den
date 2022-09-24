{ config, pkgs, lib, ... }:

{
  home.stateVersion = "22.05";

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  programs.fish = {
    enable = true;
    loginShellInit = "fish_add_path --move --prepend --path $HOME/.nix-profile/bin /run/wrappers/bin /etc/profiles/per-user/$USER/bin /nix/var/nix/profiles/default/bin /run/current-system/sw/bin /opt/homebrew/bin/";

    shellAliases = {
      vinix = "vim ~/nixos";
      nixup = "nixos-rebuild switch --use-remote-sudo --flake $HOME/nixos";
      ls = "exa -l";
      top = "btm";
      nixs = "nix-shell --run fish";
    };

    plugins = [
      {
        name = "babelfish";
        src = pkgs.fetchFromGitHub {
          owner = "bouk";
          repo = "babelfish";
          rev = "348cc55ff299bcdce307c4edc4a17e5747c07ff4";
          sha256 = "4cbR7pqbLc8RRwlP+bUDt53C6J7KtMEJtfxzSpO0Myw=";
        };
      }
    ];
  };

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

}
