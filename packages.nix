{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI Tools
    fontpreview
    wget
    git
    screenfetch
    feh
    ueberzug
    exa bat
    tty-clock
    lazygit
    ranger fzf
    unzip p7zip
    htop bottom
    surf
    ripgrep
    pinentry
    unzip
    pamixer
    acpi
    rsync
    youtube-dl
    aria2

    # Application
    nur.repos.linyinfeng.wemeet
    discord
    screenkey
    # firefox
    latest.firefox-nightly-bin
    thunderbird

    # Desktop
    conky
    flameshot
    dmenu
    autorandr

    # Music & Video
    spotify
    spotify-tui
    spotifyd
    sptlrx
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
    bintools-unwrapped
    lua
    sumneko-lua-language-server
    clangStdenv
    xorg.libXext
    clang-tools
    cmake
    gnumake
    go
    jdk
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
    # Warm up
    fahclient
  ];
}
