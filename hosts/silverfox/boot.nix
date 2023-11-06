{ pkgs }:
{
  # loader = {
  #   grub = {
  #     minegrub-theme = {
  #       enable = true;
  #       splash = "Infinite recursion";
  #     };
  #     enable = true;
  #     device = "nodev";
  #   };
  #   efi.canTouchEfiVariables = true;
  # };
  loader.systemd-boot.enable = true;
  loader.efi.canTouchEfiVariables = false;
}
