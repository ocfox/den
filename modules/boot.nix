{
  flake.modules.nixos.boot = {
    boot.loader = {
      timeout = 30;
      limine = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    system.nixos-init.enable = true;
    system.etc.overlay.enable = true;
    boot.initrd.systemd.enable = true;
  };
}
