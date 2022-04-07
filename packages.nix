{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # CLI Tools
    fontpreview
    wget
    git
    screenfetch neofetch
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
    openssl
    mpv
    xwinwrap
    ffmpeg

    # firefox
    thunderbird

    # Desktop
    conky
    flameshot
    dmenu
    autorandr
    rpiplay

    # dev
    neovim
    glfw2
    libGL
    helix
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

    # Warm up
    fahclient

    # Virt
    virt-manager
  ];
}
