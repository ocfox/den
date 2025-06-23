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

    nxr = ''nix run nixpkgs#$argv[1] -- $argv[2..-1]'';

    evs = "nix eval self#nixosConfigurations.$hostname.pkgs.$argv.version";

    # fix ssh-agent forwarding when attach to tmux
    refresh_tmux_vars = ''
      if set -q TMUX
        tmux showenv -s | string replace -rf '^((?:SSH).*?)=(".*?"); export.*' 'set -gx $1 $2' | source
      end
    '';

    haskellEnv = ''
      nix-shell -p haskell-language-server "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])"
    '';

    # TODO: should return 0 but this a fish kick
    # https://github.com/fish-shell/fish-shell/issues/7902
    # fish_command_not_found = ''
    #   if test -n $argv[2..-1]
    #       command nix run nixpkgs#$argv[1] -- $argv[2..-1]
    #   else
    #       command nix run nixpkgs#$argv[1]
    #   end
    # '';
  };
}
