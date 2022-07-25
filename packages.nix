{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # CLI Tools
    pkg-config
    fontpreview
    wget
    git
    screenfetch
    neofetch
    feh
    ueberzug
    exa
    bat
    tty-clock
    lazygit
    ranger
    fzf
    unzip
    p7zip
    htop
    bottom
    surf
    screen
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
    alejandra

    # firefox
    thunderbird-wayland

    # Desktop
    conky
    flameshot
    dmenu
    autorandr
    rpiplay

    # dev
    neovim
    texlab
    taplo-lsp
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
    rnix-lsp
    cargo
    nodejs
    nodePackages.typescript
    yarn
    (python310.withPackages (ps: with ps; [pynvim]))

    # System Tools

    # Warm up
    # fahclient

    # Virt
    virt-manager
  ];
}
