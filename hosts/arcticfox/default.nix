{ config, pkgs, ... }:
{
  time.timeZone = "Asia/Shanghai";

  users.users.ocfox = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "24.05";
}

