{
  git.enable = true;
  dconf.enable = true;
  nix-index.enable = true;

  ssh.startAgent = true;

  command-not-found.enable = false;
  fish = {
    useBabelfish = true;
    enable = true;
  };
}
