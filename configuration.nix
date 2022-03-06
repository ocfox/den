{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./overlay.nix
      ./fonts.nix
      ./packages.nix
    ];

  # Allow Unfree pkgs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  networking = {
    hostName = "whitefox"; # Define your hostname.
    useDHCP = false;

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };
  };
  programs.nm-applet.enable = true;
  programs.steam.enable = true;

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

  # Enable the X11 windowing system.
  services.xserver = {
    desktopManager.xterm.enable = false;
    layout = "us";
    # swap 'Caps Lock' & 'Escape'
    xkbOptions = "caps:swapescape";

    windowManager.dwm.enable = true;
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager = {
      defaultSession = "none+dwm";
      autoLogin = {
        enable = true;
        user = "ocfox";
      };
      lightdm.enable = true;
    };
  };

  programs.gnupg.agent.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.aria2 = {
    enable = true;
    openPorts = true;
  };

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
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  environment.variables.EDITOR = "nvim";
  environment.variables.XCURSOR_SIZE = "50";

  services.openssh.enable = true;
  system.stateVersion = "unstable";
}
