{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI Tools
    alacritty
    wget
    git
    screenfetch pfetch
    feh
    ueberzug
    exa pv bat
    tty-clock
    lazygit
    ranger
    unzip p7zip
    htop
    surf
    ripgrep
    pinentry
    unzip
    pamixer
    acpi
    rsync

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
}
