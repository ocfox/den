{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Allow Unfree pkgs
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;

  networking.hostName = "whitefox"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp6s0.useDHCP = true;

  fonts = {
    enableDefaultFonts = true;
    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        autohint = false;
      };
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "FiraCode" ];
        sansSerif = [ "DejaVu Sans" ];
        serif = [ "DejaVu Serif" ];
      };
    };

    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      sarasa-gothic
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      fira-code
      wqy_microhei
      wqy_zenhei
      nerdfonts
      symbola
    ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.picom.settings = {
    blur = {
    method = "gaussian";
    size = 10;
    deviation = 5.0;
    };
  };
  
  # Use NUR
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-communtiy/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  # gpg agent
  programs.gnupg.agent.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
            # sha256 = "0000000000000000000000000000000000000000000000000000";
      dwm = prev.dwm.overrideAttrs (old: {
          buildInputs = (old.buildInputs or []) ++ [ final.xorg.libXext ];
          src = pkgs.fetchFromGitHub {
            owner = "ocfox";
            repo = "dwm";
            rev = "e0125a88755546b132ef9f6894aafee8c9be0417";
            sha256 = "UNlxYRjDGvjGwlGXyFcbHKhuHt//+pb1w8bQSYnTK/o=";
          } ;});
      picom = prev.picom.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "jonaburg";
            repo = "picom";
            rev = "a8445684fe18946604848efb73ace9457b29bf80";
            sha256 = "R+YUGBrLst6CpUgG9VCwaZ+LiBSDWTp0TLt1Ou4xmpQ=";
          };});
      dmenu = prev.dmenu.overrideAttrs (old: {
          src = pkgs.fetchFromGitHub {
            owner = "ocfox";
            repo = "dmenu";
            rev = "967c1844df79bea0d8eaf0a981bd03b1ae5f5fa3";
            sha256 = "Bf6VEV+xWG+gr9raTeLnf0p4yB/WP6bHFYwQeq69XqY=";
          } ;});
    })
        (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  services.xserver.windowManager.dwm.enable = true;
 /* services.xserver.windowManager.xmonad = { */
 /*   enable = true; */
 /*   extraPackages = hpkgs: [ */
 /*     hpkgs.xmonad */
 /*     hpkgs.xmonad-contrib */
 /*     hpkgs.xmonad-extras */
 /*   ]; */
 /* }; */

  # zsh
  programs.zsh.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ocfox = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  # Neovim Nightly
  /* nixpkgs.overlays = [ */
  /*   (import (builtins.fetchTarball { */
  /*     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz; */
  /*   })) */
  /* ]; */

  environment.systemPackages = with pkgs; [
    # CLI Tools
    alacritty
    wezterm
    neovim
    wget
    git
    neofetch
    pfetch
    feh
    exa
    pv
    tty-clock
    lazygit
    ranger
    unzip
    htop
    surf
    ripgrep
    tree-sitter
    unzip
    pamixer
    acpi

    # Application
    tdesktop
    firefox
    spotify
    flameshot
    rofi
    dmenu
    autorandr
    polybar
    nitrogen
    mpv
    playerctl
    obs-studio

    # dev
    boost
    gcc
    clang_13
    lua
    sumneko-lua-language-server
    clangStdenv
    xorg.libXext
    clang-tools
    cmake
    gnumake
    go
    gnupg
    lua
    rustc
    rustup
    rust-analyzer
    cargo
    nodejs
    nodePackages.typescript
    yarn
    (python310.withPackages(ps: with ps; [ pynvim ]))

    # System Tools
    picom
    xclip
  ];

  services.openssh.enable = true;

  system.stateVersion = "unstable";

}

