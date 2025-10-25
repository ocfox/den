{
  flake.modules.homeManager.mako = {
    services.mako = {
      enable = true;
      settings = {
        border-size = 0;
        ignore-timeout = 1;
        default-timeout = 0;
        border-color = "#83b6af00";
        background-color = "#2b3339CC";
        font = "Sarasa Gothic J 12";
      };
    };
  };
}
