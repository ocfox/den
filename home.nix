{ pkgs, ... }:
{
  imports = [
    ./programs
    #./nvim
    ./services
  ];

  gtk = {
    enable = true;
    theme = {
      package = pkgs.materia-theme;
      name = "Materia";
    };

    iconTheme = {
      package = pkgs.numix-icon-theme-circle;
      name = "Numix-Circle";
    };
  };

  xsession.enable = true;

  xsession.pointerCursor = {
    package = pkgs.nur.repos.ambroisie.vimix-cursors;
    name = "Vimix-white-cursors";
    size = 38;
  };

  programs.home-manager.enable = true;



  home.packages = with pkgs; [
    tree
    tdesktop
    element-desktop
    qutebrowser
    qbittorrent
  ];
  home.stateVersion = "21.11";
}
