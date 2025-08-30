{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.xwayland-satellite;
in
{
  options = {
    services.xwayland-satellite = {
      enable = lib.mkEnableOption "xwayland-satellite";
    };
  };

  config = lib.mkIf cfg.enable {

    systemd.user.services.xwayland-satellite = {

      serviceConfig = {
        Description = "Xwayland outside your Wayland";
        BindsTo = "sway-session.target" ;
        PartOf = "sway-session.target" ;
        After = "sway-session.target" ;
        Requisite = "sway-session.target" ;

        Type = "notify";
        NotifyAccess = "all";
        ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite :77";
        StandardOutput = "journal";
      };
    };
  };
}
