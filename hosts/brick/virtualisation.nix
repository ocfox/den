{ pkgs }:
{
  # docker = {
  #   enable = true;
  #   rootless = {
  #     enable = true;
  #     setSocketVariable = true;
  #   };
  # };
  podman.enable = true;
  containers.enable = true;
  libvirtd.enable = true;
}
