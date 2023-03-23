{ pkgs
, lib
, username
, ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./hyprland.nix { inherit lib username pkgs; };
  };
}
