{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager.users.ocfox.programs.tmux = {
    prefix = "Escape";
  };
}
