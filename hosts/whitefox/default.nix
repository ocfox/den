{
  pkgs,
  username,
  inputs,
  lib,
  ...
}:
{
  time.timeZone = "Asia/Shanghai";

  hardware.bluetooth.enable = true;

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  chaotic.scx.enable = true;
  chaotic.mesa-git.enable = true;

  xdg = {
    mime = {
      enable = true;
      defaultApplications =
        {
          "application/x-xdg-protocol-tg" = [ "org.telegram.desktop.desktop" ];
          "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
          "x-scheme-handler/mpv" = [ "mpv-handler.desktop" ];
          "application/pdf" = [ "sioyek.desktop" ];
        }
        // lib.genAttrs [
          "x-scheme-handler/unknown"
          "x-scheme-handler/about"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
          "x-scheme-handler/mailto"
          "text/html"
        ] (_: "firefox.desktop");
    };
    # portal.wlr.enable = true;
    # portal.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.fish;
    hashedPassword = "$6$jVI2tdENaEqUyZGh$rni.joO5US9t9RYM9wlIvia4L1YOObs44Kt3gBcooBJTeSFGyEorciM2CrKMEnzbojpi1KgPPe256i5Q46N1d0";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHysCjoqwXAumW+cUCcFZDpC9yLx3Jh7x5du7r21fPE4"
    ];
    extraGroups = [
      "adbusers"
      "wheel"
      "docker"
      "dialout"
      "libvirtd"
    ];
  };

  age.secrets.factorio.file = ../../secrets/factorio.age;

  system.stateVersion = "23.05";
}
