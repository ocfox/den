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
      home-manager
    ];
  };

  flake.modules.homeManager.desktop.imports = with config.flake.modules.homeManager; [
    mpv
    sway
    terminal
  ];
}
