{ modulesPath, pkgs, ... }:
{
  imports = [
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
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHnLWTS5/vPyPFY+tCVYn3Ejf3NQpQzcGnWLQTyE7lbzAAAAC3NzaDpwYXNzZm94"
  ];

  users.users.ocfox = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$6$WqXVstk7pHt0WTmx$5s.SJYuX1g2nR1biNPVAyrQ5pxUaAWUf96Sw0.Aca8vsMoUQg8KBP6lF4wsVO4lzs4gcmffuVQWdQMxjX3loU/";
  };

  system.stateVersion = "24.11";
}
