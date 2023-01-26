{ config
, pkgs
, lib
, ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (import ./hyprland.nix { inherit pkgs; });
  };

  home.packages = with pkgs; [
    nur.repos.ocfox.swww
  ];
}
