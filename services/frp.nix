{pkgs, ...}: {
  systemd.services.frp = {
    enable = true;
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    description = "frp service";
    serviceConfig = {
      Type = "idle";
      User = "ocfox";
      Restart = "on-failure";
      RestartSec = "60s";
      ExecStart = ''/home/ocfox/tools/sakurafrp -c /home/ocfox/tools/frpc.ini'';
    };
  };
}
