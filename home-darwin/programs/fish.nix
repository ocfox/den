{
  loginShellInit = ''for p in (string split " " $NIX_PROFILES); fish_add_path --prepend --move $p/bin; end'';

  functions = {
    rebuild = ''
      darwin-rebuild switch --flake $HOME/nixos#silverfox
    '';
  };
}
