{ config
, pkgs
, username
, ...
}: {
  imports = [
    ./hardware.nix
    ./fonts.nix
    ./packages.nix
    ./env.nix
    ../../devices
    ../../overlays
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  virtualisation.libvirtd.enable = true;

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
      dates = "Sun 14:00";
    };

    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      auto-optimise-store = true;
    };
  };

  security.polkit.enable = true;

  boot.loader = {
    grub2-theme = {
      enable = true;
      theme = "whitesur";
      screen = "2k";
    };
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  time.timeZone = "Asia/Shanghai";

  networking = {
    firewall.enable = false;
    hostName = "whitefox";
    useDHCP = false;

    networkmanager = {
      enable = true;
    };
  };

  programs = {
    nm-applet.enable = true;
    nix-ld.enable = true;
    steam.enable = false;
    gnupg.agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableSSHSupport = true;
    };
    dconf.enable = true;
    fish = {
      useBabelfish = true;
      enable = true;
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-chinese-addons
        fcitx5-configtool
      ];
    };
  };

  services = {
    getty.autologinUser = username;
    devmon.enable = true;
    printing.enable = true;
    blueman.enable = true;
    openssh.enable = true;
    udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0666", TAG+="uaccess", TAG+="udev-acl"
    '';
  };

  hardware.video.hidpi.enable = true;
  hardware.bluetooth.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    hashedPassword = "$6$jVI2tdENaEqUyZGh$rni.joO5US9t9RYM9wlIvia4L1YOObs44Kt3gBcooBJTeSFGyEorciM2CrKMEnzbojpi1KgPPe256i5Q46N1d0";
    extraGroups = [
      "wheel"
      "libvirtd"
    ];
  };

  environment.variables.EDITOR = "nvim";

  system.stateVersion = "unstable";
}
