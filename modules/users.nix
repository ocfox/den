{
  flake.modules.nixos.users = {
    users = {
      mutableUsers = false;
      users = {
        root.isSystemUser = true;
        ocfox = {
          isNormalUser = true;
          hashedPassword = "$6$jVI2tdENaEqUyZGh$rni.joO5US9t9RYM9wlIvia4L1YOObs44Kt3gBcooBJTeSFGyEorciM2CrKMEnzbojpi1KgPPe256i5Q46N1d0";
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHysCjoqwXAumW+cUCcFZDpC9yLx3Jh7x5du7r21fPE4"
            "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHnLWTS5/vPyPFY+tCVYn3Ejf3NQpQzcGnWLQTyE7lbzAAAAC3NzaDpwYXNzZm94 ssh:passfox"
          ];
          extraGroups = [
            "adbusers"
            "wheel"
            "podman"
            "networkmanager"
            "realtime"
            "dialout"
            "libvirtd"
          ];
        };
      };
    };

    services.userborn.enable = true;
  };
}
