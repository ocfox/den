{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    extraPackages = with pkgs; [
      swaybg
      bemenu
      grim
      slurp
    ];
  };
}
