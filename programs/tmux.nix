{ pkgs
, ...
}:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    prefix = "`";
    baseIndex = 1;
    escapeTime = 0;
    customPaneNavigationAndResize = true;
    keyMode = "vi";

    plugins = with pkgs.tmuxPlugins; [
      onedark-theme
      prefix-highlight
      vim-tmux-navigator
    ];

    extraConfig = ''
      set -g mouse on
    '';
  };
}
