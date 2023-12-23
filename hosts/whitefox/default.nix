{ pkgs
, username
, ...
}: {
  time.timeZone = "Asia/Shanghai";

  hardware.bluetooth.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    hashedPassword = "$6$jVI2tdENaEqUyZGh$rni.joO5US9t9RYM9wlIvia4L1YOObs44Kt3gBcooBJTeSFGyEorciM2CrKMEnzbojpi1KgPPe256i5Q46N1d0";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHysCjoqwXAumW+cUCcFZDpC9yLx3Jh7x5du7r21fPE4"
    ];
    extraGroups = [
      "wheel"
      "docker"
      "libvirtd"
    ];
  };

  age.secrets.factorio.file = ../../secrets/factorio.age;

  system.stateVersion = "23.05";
}
