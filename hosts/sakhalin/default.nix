{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    curl
    htop
    wget
    git
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOqoRDiXXxBKU0FjnT2YcFnczYBKMKXGPgD9IVfBg5gq"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHnLWTS5/vPyPFY+tCVYn3Ejf3NQpQzcGnWLQTyE7lbzAAAAC3NzaDpwYXNzZm94"
  ];

  system.stateVersion = "24.05";
}
