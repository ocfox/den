{
  flake.modules.nixos.shell =
    { pkgs, ... }:
    {
      users.users.ocfox.shell = pkgs.fish;
      programs.fish.enable = true;
      programs.fzf = {
        keybindings = true;
        fuzzyCompletion = true;
      };
      programs.ssh.startAgent = true;
    };

  flake.modules.homeManager.shell =
    { pkgs, lib, ... }:
    {
      programs = {
        atuin = {
          enable = true;
          settings = {
            auto_sync = true;
            sync_frequency = "5m";
            sync_address = "https://atuin.ocfox.me";
            search_mode = "fuzzy";
          };
        };
        eza = {
          enable = true;
          enableFishIntegration = true;
          icons = "auto";
          git = true;
        };
        fish = {
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
          };
        };
      };

      # tide
      home.activation.configure-tide = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs.fish}/bin/fish -c "tide configure --auto --style=Lean --prompt_colors='16 colors' --show_time='12-hour format' --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No"
      '';
    };
}
