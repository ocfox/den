{ config, lib, pkgs, ... }:
{
  services.picom = {
    enable = true;
    fade = true;
    backend = "glx";
    blur = true;

    extraOptions = ''
      inactive-opacity = 0.8;
      frame-opacity = 0.7;
      blur-strength = 5;
      blur-method = "kawase";
      blur-kern = "3x3box";
    '';
  };
}
