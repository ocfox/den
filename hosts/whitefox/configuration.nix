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

  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    libvirtd.enable = true;
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
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

    wireguard.interfaces = {
      wg0 = {
        ips = [ "10.0.0.7/24" ];
        listenPort = 51820;
        privateKey = "UGD+jzUJCrd+PUVDLq1Dysd+d+BX5YCaObNiCzgIxGw=";
        peers = [
          {
            publicKey = "BhOuRTB2juG1EyzmPup373PPlWHK6a8xsk6fPtrOHjQ=";
            allowedIPs = [ "10.0.0.0/24" ];
            endpoint = "174.138.27.173:51820";
            persistentKeepalive = 25;
          }
          {
            publicKey = "xN5i8n5hKOsiNxC4TVQ2JVdOvuKF2NQCbcaPMgG/uxQ=";
            allowedIPs = [ "10.0.0.0/24" ];
            persistentKeepalive = 25;
          }
        ];
      };
    };

    networkmanager = {
      enable = true;
    };
  };

  programs = {
    git.enable = true;
    nm-applet.enable = true;
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

    postgresql = {
      enable = true;
      extraPlugins = with pkgs.postgresql_14.pkgs; [ postgis ];
      package = pkgs.postgresql_14;
    };
    blueman.enable = true;
    openssh.enable = true;
    v2raya.enable = true;
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
      "docker"
      "libvirtd"
    ];
  };

  system.stateVersion = "unstable";
}
