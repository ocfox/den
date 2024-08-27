{ pkgs, ... }:
{

  zramSwap.enable = true;
  environment.systemPackages = with pkgs; [
    curl
    htop
    tmux
    wget
    git
    hysteria
    helix
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOqoRDiXXxBKU0FjnT2YcFnczYBKMKXGPgD9IVfBg5gq"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHdb8Q3KlGGbHUjT8vBmCPn+99F0fWzREC20bD6dCkUJ"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHnLWTS5/vPyPFY+tCVYn3Ejf3NQpQzcGnWLQTyE7lbzAAAAC3NzaDpwYXNzZm94"
  ];

  system.stateVersion = "24.05";
}
