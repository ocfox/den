{ pkgs
, ...
}: {
  security.pam.u2f.enable = true;
  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    ccid
    nur.repos.linyinfeng.canokey-udev-rules
  ];
}
