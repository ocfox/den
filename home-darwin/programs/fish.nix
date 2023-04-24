{
  functions = {
    rebuild = ''
      darwin-rebuild switch --use-remote-sudo --flake $HOME/nixos#silverfox
    '';
  };
}
