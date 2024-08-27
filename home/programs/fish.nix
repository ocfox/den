{ pkgs }:
{
  enable = true;
  plugins = [
    {
      name = "tide";
      src = pkgs.fishPlugins.tide.src;
    }
    {
      name = "forgit";
      src = pkgs.fishPlugins.forgit.src;
    }
  ];

  functions = {
    fish_greeting = "uname -a; w";

    post = "curl -X PUT --data-binary @$argv https://pastb.in";

    poststd = ''curl -X PUT --data-binary "@-" https://pastb.in'';

    ns = "nix shell nixpkgs#{ $argv }";

    # fix ssh-agent forwarding when attach to tmux
    refresh_tmux_vars = ''
      if set -q TMUX
        tmux showenv -s | string replace -rf '^((?:SSH).*?)=(".*?"); export.*' 'set -gx $1 $2' | source
      end
    '';

    haskellEnv = ''
      nix-shell -p haskell-language-server "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])"
    '';
  };
}
