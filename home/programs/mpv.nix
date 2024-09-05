{ pkgs }:
{
  enable = true;
  scripts = [ pkgs.mpvScripts.uosc ];
  config = {
    vo = "gpu-next";
    gpu-api = "vulkan";
    hwdec = "vaapi";
    gpu-context = "waylandvk";
  };
}
