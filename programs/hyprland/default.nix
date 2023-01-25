{ config
, pkgs
, lib
, ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = (import ./hyprland.nix { inherit pkgs; });
  };
}
