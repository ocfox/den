{ username, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.auto-optimise-store = true;
  };

  boot.cleanTmpDir = true;
  zramSwap.enable = true;
  networking.hostName = "arcticfox";
  networking.domain = "";
  services.openssh.enable = true;

  programs = {
    fish = {
      useBabelfish = true;
      enable = true;
    };
  };

  users.users.${username} = {
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    isNormalUser = true;
    hashedPassword = "$6$jVI2tdENaEqUyZGh$rni.joO5US9t9RYM9wlIvia4L1YOObs44Kt3gBcooBJTeSFGyEorciM2CrKMEnzbojpi1KgPPe256i5Q46N1d0";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7T3i91+oIlQqOfOfW9k8V9wkFRnDa9EqiEjZXB9Hfz i@ocfox.me"
    ];
  };

  environment.variables.EDITOR = "nvim";
}
