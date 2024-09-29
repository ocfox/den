{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.shadowsocks-rust;
  settingsFormat = pkgs.formats.json { };
  configfile = settingsFormat.generate "config.json" cfg.settings;
in
{
  options = {
    services.shadowsocks-rust = {
      enable = lib.mkEnableOption "shadowsocks-rust";
      settings = lib.mkOption {
        type = lib.types.submodule { freeformType = settingsFormat.type; };
        default = { };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.etc."shadowsocks-rust/config.json".source = configfile;

    systemd.services.shadowsocks-rust = {
      CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_BIND_SERVICE";
      wantedBy = [ "multi-user.target" ];
      ExecStart = "${lib.getExe pkgs.shadowsocks-rust} -c /etc/shadowsocks-rust/config.json";
    };
  };
}
