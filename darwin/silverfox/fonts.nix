{ pkgs }:
{
  fontDir.enable = true;

  fonts = with pkgs; [
    recursive
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
