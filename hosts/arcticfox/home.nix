{ config
, pkgs
, lib
, ...
}:
{
  imports = [
    ../../programs
  ];

  home.packages = with pkgs; [
    coreutils
    git
    curl
    wget
    neovim
    ripgrep
    lazygit
    jq
  ];

  home.stateVersion = "22.05";
}
