{ pkgs, inputs, ... }:
with pkgs;
[
  inputs.agenix.packages.x86_64-linux.default
  wget
  bat
  comma
  fzf
  lazygit
  ranger
  unzip
  p7zip
  htop
  bottom
  screen
  ripgrep
  unzip
  rsync
]
