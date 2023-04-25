{
  functions = {
    rebuild = ''
      darwin-rebuild switch --flake $HOME/nixos#silverfox
    '';
  };
}
