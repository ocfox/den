{ pkgs, ... }:
{

  facter.reportPath = ./facter.json;

  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;

  boot.kernel.sysctl = {
    "net.ipv6.conf.all.forwarding" = true;
    "net.ipv4.conf.all.forwarding" = true;
  };

  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    tmux
    htop
    helix
    curl
    wget
    git
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII1aPYQdMlV8bEiaUezXiQPxcz0CckzCwxIP/KZQ5Lz/"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHnLWTS5/vPyPFY+tCVYn3Ejf3NQpQzcGnWLQTyE7lbzAAAAC3NzaDpwYXNzZm94"
  ];

  system.stateVersion = "24.05";
}
