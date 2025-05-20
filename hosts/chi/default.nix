{
  modulesPath,
  config,
  pkgs,
  ...
}:
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

  vaultix = {
    settings.hostPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID8IVBgnE6cfei0k4va0fyzyoh9o62f9yM3FwGhnPJON root@chi";
    secrets.drive = {
      file = ../../secrets/drive.age;
      mode = "640";
    };
  };

  fileSystems."/var/lib/immich/library" = {
    device = "immich:immich";
    fsType = "rclone";
    options =
      let
        configPath = config.vaultix.secrets.drive.path;
      in
      [
        "nodev"
        "nofail"
        "allow_other"
        "args2env"
        "vfs-cache-mode=writes"
        "config=${configPath}"
      ];
  };

  environment.systemPackages = with pkgs; [
    rclone
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

  system.stateVersion = "24.11";
}
