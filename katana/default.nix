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
  services.skhd = {
    skhdConfig = ''
      cmd - h : yabai -m window --focus west
      cmd - j : yabai -m window --focus south
      cmd - k : yabai -m window --focus north
      cmd - l : yabai -m window --focus east
      cmd - f : yabai -m window --toggle zoom-fullscreen
      cmd + shift - h : yabai -m window --warp west
      cmd + shift - l : yabai -m window --warp east

      cmd - return : open -n -a "Alacritty"

      cmd + shift - q : yabai -m window --close

      cmd - 1 : yabai -m space --focus 1
      cmd - 2 : yabai -m space --focus 2
      cmd - 3 : yabai -m space --focus 3
      cmd - 4 : yabai -m space --focus 4
      cmd - 5 : yabai -m space --focus 5
      cmd - 6 : yabai -m space --focus 6

      cmd + shift - 1 : yabai -m window --space 1
      cmd + shift - 2 : yabai -m window --space 2
      cmd + shift - 3 : yabai -m window --space 3
      cmd + shift - 4 : yabai -m window --space 4
      cmd + shift - 5 : yabai -m window --space 5
    '';
    enable = true;
  };
  home-manager.users.ed.programs.keychain.enable = true;

  home-manager.users.ed.programs.alacritty.settings.font.size = 16;

  environment.systemPackages = with pkgs; [
    lazygit
    htop
    fish
    ripgrep
    git
  ];

  services.yabai = {
    enableScriptingAddition = true;
    config = {
      focus_follows_mouse = "autoraise";
      layout = "bsp";
      mouse_follows_focus = "on";
      window_placement = "second_child";
      window_opacity = "off";
      top_padding = 5;
      bottom_padding = 5;
      left_padding = 5;
      right_padding = 5;
      window_gap = 5;
    };
    enable = true;
  };

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
      "node"
    ];

    casks = [
      "firefox"
      "visual-studio-code"

      "alacritty"

      "telegram"

      "iina" # video player
      "zed"
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
