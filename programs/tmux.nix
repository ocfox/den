{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.ocfox.programs.tmux = {
    # enable = true;
    prefix = "C-Space";
    keyMode = "vi";
  };
}
