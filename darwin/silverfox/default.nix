{ pkgs, ... }:
{
  nix.settings.trusted-users = [
    "@admin"
  ];

  nix.configureBuildUsers = true;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  nixpkgs.config.allowUnfree = true;

  programs.fish.enable = true;

  services.nix-daemon.enable = true;

  environment.shells = [ pkgs.fish ];

  users.users.ocfox = {
    shell = pkgs.fish;
  };

  fonts.fontDir.enable = true;

  fonts.fonts = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

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
