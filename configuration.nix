{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Allow Unfree pkgs
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  networking = {
    hostName = "whitefox"; # Define your hostname.
    useDHCP = false;
    interfaces.enp6s0.useDHCP = true;

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };
  };

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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-configtool
      ];
    };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    layout = "us";
    # swap 'Caps Lock' & 'Escape'
    xkbOptions = "caps:swapescape";

    windowManager.dwm.enable = true;
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager = {
      defaultSession = "none+dwm";
      autoLogin = {
        enable = true;
        user = "ocfox";
      };
      lightdm.enable = true;
    };
  };

  programs.gnupg.agent.enable = true;

  # Use NUR
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  nixpkgs.overlays = [
    (self: super: {
     neovim = super.neovim.override {
       viAlias = true;
       vimAlias = true;
     };
   })

    (final: prev: {
            # sha256 = "0000000000000000000000000000000000000000000000000000";
      dwm = prev.dwm.overrideAttrs (old: {
          buildInputs = (old.buildInputs or []) ++ [ final.xorg.libXext ];
          # src = pkgs.fetchFromGitHub {
          #   owner = "ocfox";
          #   repo = "dwm";
          #   rev = "e0125a88755546b132ef9f6894aafee8c9be0417";
          #   sha256 = "UNlxYRjDGvjGwlGXyFcbHKhuHt//+pb1w8bQSYnTK/o=";
          # }

          src = /home/ocfox/suckless/dwm
          ;});
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
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    tcp = {
      enable = true;
      anonymousClients.allowedIpRanges = ["127.0.0.1"];
    };
  };

  users.users.ocfox = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  environment.variables.EDITOR = "nvim";
  environment.systemPackages = with pkgs; [
    # CLI Tools
    alacritty
    wget
    git
    screenfetch
    pfetch
    feh
    ueberzug
    exa
    pv
    tty-clock
    lazygit
    ranger
    unzip
    p7zip
    htop
    surf
    ripgrep
    pinentry
    unzip
    pamixer
    acpi
    bat

    # Application
    nur.repos.ilya-fedin.kotatogram-desktop
    screenkey
    firefox

    # Desktop
    picom
    conky
    flameshot
    dmenu
    autorandr

    # Music & Video
    spotify
    playerctl
    cava
    vlc
    obs-studio

    # dev
    neovim
    tree-sitter
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
    xclip

    # Game
    minecraft
  ];

  services.openssh.enable = true;
  system.stateVersion = "unstable";
}
