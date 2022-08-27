{ config
, lib
, pkgs
, ...
}: {
  home-manager.users.ocfox.programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.8;
        # decorations = none;
      };
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 16.5;
      };

      colors = {
        primary = {
          background = "0x2b3339";
          foreground = "0xd8caac";
        };

        normal = {
          black = "0x090618";
          red = "0xc34043";
          green = "0x76946a";
          yellow = "0xc0a36e";
          blue = "0x7e9cd8";
          magenta = "0x957fb8";
          cyan = "0x6a9589";
          white = "0xc8c093";
        };
        bright = {
          black = "0x727169";
          red = "0xe82424";
          green = "0x98bb6c";
          yellow = "0xe6c384";
          blue = "0x7fb4ca";
          magenta = "0x938aa9";
          cyan = "0x7aa89f";
          white = "0xdcd7ba";
        };

        selection = {
          background = "0x2d4f67";
          foreground = "0xc8c093";
        };
      };
    };
  };
}
