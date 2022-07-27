{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./overlay.nix
    ./fonts.nix
    ./packages.nix
    ./env.nix
    ./programs
    ./services/frp.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    permittedInsecurePackages = ["libdwarf-20210528"];
  };

  virtualisation.libvirtd.enable = true;

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    # garbage collect
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
      dates = "Sun 14:00";
    };
    settings.auto-optimise-store = true;

    nixPath = [
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
      "nixos-config=/home/ocfox/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
  };

  security.pam.u2f.enable = true;
  services.pcscd.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_zen;
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
    steam.enable = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    dconf.enable = true;
    fish.enable = true;
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

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  # };

  # Enable the X11 windowing system.
  services = {
    getty.autologinUser = "ocfox";
    #   xserver = {
    #     layout = "us";
    #     # swap 'Caps Lock' & 'Escape'
    #     # xkbOptions = "caps:swapescape";
    #
    #     windowManager.dwm.enable = true;
    #     dpi = 144;
    #
    #     # windowManager.leftwm.enable = true;
    #     enable = true;
    #     videoDrivers = ["amdgpu"];
    #     displayManager = {
    #       sddm.enable = true;
    #     };
    #   };

    printing.enable = true;
    blueman.enable = true;
    openssh.enable = true;

    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        userServices = true;
      };
    };
  };

  hardware.video.hidpi.enable = true;
  sound.enable = true;
  hardware.bluetooth.enable = true;

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    tcp = {
      enable = true;
      anonymousClients.allowedIpRanges = ["127.0.0.1"];
    };
  };

  users.users.ocfox = {
    isNormalUser = true;
    extraGroups = ["wheel" "libvirtd"];
    shell = pkgs.fish;
  };

  environment.variables.EDITOR = "nvim";

  system.stateVersion = "unstable";
}
