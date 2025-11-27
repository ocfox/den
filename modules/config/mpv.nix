{
  flake.modules.nixos.mpv = { lib, pkgs, config, ... }:
  {
    my.packages = [ pkgs.mpv pkgs.mpvScripts.uosc ];

    my.config = {
      mpv = {
        "mpv.conf" = pkgs.writeText "mpv.conf" (lib.generators.toKeyValue { } {
          vo = "gpu-next";
          gpu-api = "vulkan";
          hwdec = "vaapi";
          gpu-context = "waylandvk";
          cache = "yes";
          "demuxer-max-back-bytes" = "1G";
          "demuxer-max-bytes" = "2G";
        });
      };
      "mpv/scripts" = {
        # Assuming the main script file is uosc.lua. The pkgs.mpvScripts.uosc is a derivation containing the script.
        "uosc.lua" = pkgs.mpvScripts.uosc;
      };
    };
  };
}
