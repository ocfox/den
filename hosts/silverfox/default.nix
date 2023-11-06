{ pkgs
, username
, ...
}: {
  time.timeZone = "Asia/Shanghai";

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    hashedPassword = "$6$jVI2tdENaEqUyZGh$rni.joO5US9t9RYM9wlIvia4L1YOObs44Kt3gBcooBJTeSFGyEorciM2CrKMEnzbojpi1KgPPe256i5Q46N1d0";
    extraGroups = [
      "wheel"
    ];
  };

  system.stateVersion = "23.05";
}
