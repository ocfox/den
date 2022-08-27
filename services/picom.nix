{ config
, lib
, pkgs
, ...
}: {
  services.picom = {
    # enable = true;
    enable = false;
    fade = true;
    backend = "glx";
    vSync = true;
    opacityRules = [ "100:class_g = 'dwm'" "100:class_g = 'KotatogramDesktop'" "100:class_g = 'firefox-aurora'" ];
    shadow = false;
    shadowOpacity = "0.6";
    shadowExclude = [ "class_g = 'dwmsystray'" "class_g = 'conky'" "class_g = 'firefox-aurora' && argb" "class_g = 'KotatogramDesktop' && argb" "class_g = 'KotatogramDesktop'" ];
    shadowOffsets = [ (-17) (-17) ];
    inactiveOpacity = "0.95";
    experimentalBackends = true;

    settings = {
      corner-radius = 9.0;
      rounded-corners-exclude = [
        "class_g = 'dwm'"
      ];
      shadow-radius = 17;
      frame-opacity = 0.7;
      blur-strength = 5;
      blur-method = "kawase";
      blur-kern = "3x3box";
    };
  };
}
