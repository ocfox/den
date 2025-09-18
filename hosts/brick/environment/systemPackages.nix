{ pkgs, inputs, ... }:
with pkgs;
[
  nautilus

  wget
  bat
  fzf
  lazygit
  ranger
  unzip
  p7zip
  htop
  bottom

  sing-box

  screen
  ripgrep
  pinentry
  unzip
  pamixer
  acpi
  rsync
  aria2
  openssl
  mpv
  xwinwrap
  polkit_gnome
  thunderbird
  mpv-handler
  sioyek

  nix-heuristic-gc

  foliate # epub reader
]
