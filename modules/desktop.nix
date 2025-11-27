{ config, ... }:
{
  flake.modules.nixos.desktop = {
    programs.sway.enable = true;
    imports = with config.flake.modules.nixos; [
      # System-level desktop modules
      xdg
      fonts
      fcitx
      audio
      networkmanager

      # Migrated application modules
      foot
      git
      mako
      waybar
      gtk
      mpv
      helix
      shell
    ];
  };
}
