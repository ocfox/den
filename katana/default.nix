{
  pkgs,
  lib,
  config,
  ...
}:
{
  nix.enable = false;
  networking.hostName = "katana";
  networking.computerName = "katana";
  system.defaults.smb.NetBIOSName = "katana";

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  users.users.ed = {
    home = "/Users/ed";
  };

  system.primaryUser = "ed";

  system = {
    stateVersion = 6;
  };

  environment.variables.EDITOR = "hx";

  services.openssh.enable = true;
  home-manager.users.ed.programs.keychain.enable = true;

  home-manager.users.ed.programs.alacritty.settings.font.size = 16;

  environment.systemPackages = with pkgs; [
    lazygit
    htop
    fish
    ripgrep
    git
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # TODO Feel free to add your favorite apps here.

      # Xcode = 497799835;
      # Wechat = 836500024;
      # NeteaseCloudMusic = 944848654;
      # QQ = 451108668;
      # WeCom = 1189898970;  # Wechat for Work
      # TecentMetting = 1484048379;
      # QQMusic = 595615424;
    };

    taps = [
      # "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    brews = [
      # "wget" # download tool
      # "curl" # no not install curl via nixpkgs, it's not working well on macOS!
      # "aria2" # download tool
      # "httpie" # http client
    ];

    casks = [
      "firefox"
      "visual-studio-code"

      "alacritty"

      "telegram"

      "iina" # video player
      # "stats" # beautiful system monitor
    ];
  };

  fonts = {
    # fontconfig = {
    #   enable = true;
    #   antialias = true;
    #   defaultFonts = {
    #     emoji = [ "Noto Color Emoji" ];
    #     sansSerif = [
    #       "Inter"
    #       "Microsoft YaHei"
    #     ];
    #     serif = [
    #       "Roboto Serif"
    #       "Microsoft YaHei"
    #     ];
    #     monospace = [ "JetBrainsMono Nerd Font" ];
    #   };
    # };

    # fontDir.enable = true;
    packages = with pkgs; [
      vistafonts-chs
      inter
      roboto
      roboto-serif
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
    ];
  };

  programs.fish.enable = true;
  programs.bash.enable = true;

  nix.settings.trusted-users = [ "ed" ];
}
