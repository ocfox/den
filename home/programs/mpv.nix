{ pkgs }:
{
  enable = true;
  scripts = [ pkgs.mpvScripts.uosc ];
  config = {
    gpu-context = "wayland";
    hwdec = "auto-safe";
    profile = "gpu-hq";
    vo = "gpu";
  };
}
