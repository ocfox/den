{ modulesPath, pkgs, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  facter.reportPath = ./facter.json;

  security.acme.defaults.email = "civet@ocfox.me";
  security.acme.acceptTerms = true;

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  boot.initrd = {
    compressor = "zstd";
    compressorArgs = [
      "-19"
      "-T0"
    ];
    systemd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    hysteria
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
