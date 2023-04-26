{
  settings.trusted-users = [
    "@admin"
  ];
  configureBuildUsers = true;
  extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
}
