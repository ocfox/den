{
  # Fix swayidle condition unmet WAYLAND_DISPLAY not set
  user.services.swayidle.Unit.After = [ "graphical-session.target" ];
}
