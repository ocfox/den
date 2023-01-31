{pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
    package = pkgs.neovim-unwrapped;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      aerial-nvim
      nvim-cmp
      cmp_luasnip
      cmp-buffer
      cmp-nvim-lsp
      cmp-cmdline
      cmp-path
      luasnip
      everforest
      vim-rooter
      nui-nvim
      vim-devicons
      telescope-nvim
      telescope-fzf-native-nvim
      neo-tree-nvim
      toggleterm-nvim
      which-key-nvim
      bufferline-nvim
      #heirline-nvim
      impatient-nvim
      nvim-notify
      FixCursorHold-nvim
      nvim-autopairs
      nvim-ts-rainbow
      nvim-ts-autotag
      nvim-ts-context-commentstring
      gitsigns-nvim
      comment-nvim
      lspkind-nvim
      indent-blankline-nvim
      better-escape-nvim
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          nix
          lua
          rust
          c
          go
          hcl
        ]
      ))
    ];
    #extraConfig = ''
    #  :source ${./nvim.lua}
    #'';
  };

  home.packages = with pkgs; [
    nil
    texlab
  ];
}
