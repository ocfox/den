{ pkgs, lib, ... }:
{

  nix.settings.substituters = [
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  nix.settings.trusted-users = [
    "@admin"
  ];
  nix.configureBuildUsers = true;

  users.users.ocfox.shell = pkgs.fish;

  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  programs.fish.enable = true;

  homebrew = {
    enable = true;

    taps = [
      "koekeishiya/formulae"
    ];

    brews = [
      "yabai"
      "skhd"
    ];
  };

  services.nix-daemon.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
  ];

  environment.shells = with pkgs; [ fish ];

  programs.nix-index.enable = true;

  fonts.fontDir.enable = true;

  fonts.fonts = with pkgs; [
     recursive
     (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
   ];

  nixpkgs.overlays = [
    (self: super: {
      neovim = super.neovim.override {
        viAlias = true;
        vimAlias = true;
      };
    })
  ];

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  security.pam.enableSudoTouchIdAuth = true;
}
