{ config, ... }:
{
  flake.modules.nixos.desktop = {
    programs.sway.enable = true;
    imports = with config.flake.modules.nixos; [
      xdg
      fonts
      fcitx
      audio
      networkmanager

      foot
      mako
      waybar
      gtk
      mpv
      sway
    ];
  };
}
