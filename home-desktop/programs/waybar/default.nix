{
  enable = true;
  style = builtins.readFile ./waybar.css;
  systemd.enable = true;
}
