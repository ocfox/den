{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "everforest_dark";
      editor = {
        line-number = "relative";
        mouse = false;
      };
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };

      keys = import ./keymaps.nix;
    };
    languages = import ./languages.nix { inherit pkgs; };
  };
}
