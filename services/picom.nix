{ config, lib, pkgs, ... }:
{
  services.picom = {
    enable = true;
    fade = true;
    backend = "glx";
    blur = true;
    blurExclude = [ "class_g = 'dwmsystray'" "class_g = 'conky'" ];
    opacityRule = [ "100:class_g = 'dwm'" ];
    shadow = true;
    shadowOpacity = "0.9";
    shadowExclude = [ "class_g = 'dwmsystray'" "class_g = 'conky'" ];
    inactiveOpacity = "0.95";

    extraOptions = ''
      frame-opacity = 0.7;
      blur-strength = 5;
      blur-method = "kawase";
      blur-kern = "3x3box";
    '';
  };
}
