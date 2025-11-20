{
  flake.modules.nixos.android =
    { pkgs, ... }:
    {
      programs.adb.enable = true;
      users.users.ocfox.extraGroups = [ "adbusers" ];
      environment.systemPackages = [
        pkgs.android-studio
      ];
      # nixpkgs.config.android_sdk.accept_license = true;
    };
}
