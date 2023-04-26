{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;

  environment.shells = [ pkgs.fish ];

  users.users.ocfox = {
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    coreutils
    git
    curl
    wget
    ripgrep
    lazygit
  ];

  security.pam.enableSudoTouchIdAuth = true;
}
