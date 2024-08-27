{
  enable = true;
  userName = "ocfox";
  userEmail = "i@ocfox.me";
  extraConfig.gpg.format = "ssh";

  signing = {
    signByDefault = true;
    key = "key::sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHnLWTS5/vPyPFY+tCVYn3Ejf3NQpQzcGnWLQTyE7lbzAAAAC3NzaDpwYXNzZm94";
  };
}
