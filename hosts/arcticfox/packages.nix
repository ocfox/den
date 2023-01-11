{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    curl
    git
    wget
    clang
    bat
  ];
}
