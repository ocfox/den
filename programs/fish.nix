{ pkgs
, ...
}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      vinix = "vim ~/nixos";
    };

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
      fish_greeting = "w";

      rebuild = ''
        if test (uname) = "Linux"
          set os "nixos"
        else
          set os "darwin"
        end
        $os-rebuild switch --use-remote-sudo --flake $HOME/nixos#$hostname
      '';

      post = ''
        curl -F "c=@$argv" https://pastb.in
      '';

      ns = ''
        nix shell nixpkgs#{ $argv }
      '';


      haskellEnv = ''
        nix-shell -p haskell-language-server "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])"
      '';
    };
  };
}
