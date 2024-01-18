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

    post = ''curl -F "c=@$argv" https://pastb.in'';

    poststd = ''curl -F "c=@-" https://pastb.in'';

    ns = ''nix shell nixpkgs#{ $argv }'';

    haskellEnv = ''
      nix-shell -p haskell-language-server "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])"
    '';
  };
}
