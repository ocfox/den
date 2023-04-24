{
  interactiveShellInit = ''
    if test (id --user $USER) = 1000 && test (tty) = "/dev/tty1"
      exec sway
    end
  '';

  functions = {
    rebuild = ''
      nixos-rebuild switch --use-remote-sudo --flake $HOME/nixos#whitefox
    '';
  };
}
