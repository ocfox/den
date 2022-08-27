{ config
, lib
, pkgs
, ...
}: {
  home-manager.users.ocfox.programs.nnn = {
    enable = true;
    package = pkgs.nnn.override { withNerdIcons = true; };
    plugins = {
      mappings = {
        v = "imgview";
      };
    };
  };
}
