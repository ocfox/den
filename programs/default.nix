{ config, lib, pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./fish.nix
  ];
}