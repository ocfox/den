{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    curl
    wget
    bat
  ];
}
