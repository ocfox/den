{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI Tools
    alacritty
    fontpreview
    wget
    git
    screenfetch pfetch
    feh
    ueberzug
    exa pv bat
    tty-clock
    lazygit
    ranger fzf zoxide du-dust
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

    # Application
    tdesktop
    nur.repos.linyinfeng.wemeet
    discord
    screenkey
    # firefox
    latest.firefox-nightly-bin
    thunderbird

    # Desktop
    picom
    conky
    flameshot
    dmenu
    autorandr

    # Music & Video
    spotify
    spotify-tui
    spotifyd
    # sptlrx
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
