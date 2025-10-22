{
  flake.modules.homeManager.mpv =
    { pkgs, ... }:
    {
      programs.mpv = {
        enable = true;
        scripts = [ pkgs.mpvScripts.uosc ];
        config = {
          vo = "gpu-next";
          gpu-api = "vulkan";
          hwdec = "vaapi";
          gpu-context = "waylandvk";
          cache = "yes";
          demuxer-max-back-bytes = "1G";
          demuxer-max-bytes = "2G";
        };
      };
    };
}
