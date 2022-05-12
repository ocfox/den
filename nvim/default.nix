{
  pkgs,
  lib,
  ...
}: let
  vim-plugins = import ./plugins.nix {inherit pkgs lib;};
  nixos-unstable = import <unstable> {};
in {
  home.packages = with pkgs; [
    nodePackages.pyright
    tree-sitter
    luaPackages.lua-lsp
    rnix-lsp
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-sleuth
      FixCursorHold-nvim
      impatient-nvim
      vim-markdown-toc
      markdown-preview-nvim
      vim-markdown
      vim-table-mode
      nvim-colorizer-lua
      vim-fugitive
      lazygit-nvim
      kanagawa-nvim
    ];

    # extraConfig = builtins.readFile ./init.lua;
  };
}
