{
  flake.modules.nixos.boot =
    { config, ... }:
    {
      boot.loader = {
        timeout = 30;
        limine = {
          enable = true;
        };
        efi.canTouchEfiVariables = true;
      };

      system.nixos-init.enable = true;
      system.etc.overlay.enable = true;
      system.etc.overlay.mutable = false;
      boot.initrd.systemd.enable = true;
      environment.etc = {
        "machine-id".text = builtins.hashString "md5" (config.networking.hostName) + "\n";
        "NIXOS".text = "";
      };
    };
}
