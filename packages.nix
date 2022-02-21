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

    # Application
    tdesktop
    nur.repos.linyinfeng.wemeet
    discord
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
