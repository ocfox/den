{ config
, lib
, pkgs
, ...
}:
{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    prefix = "`";
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      nord
      prefix-highlight
    ];
  };
}
