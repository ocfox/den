{
  flake.modules.nixos.git =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      my.packages = [
        pkgs.git
        pkgs.lazygit
      ];

      my.config.git = {
        "config" = pkgs.writeText "git-config" (
          lib.generators.toINI { } {
            gpg = {
              format = "ssh";
            };
            user = {
              name = "ocfox";
              email = "i@ocfox.me";
            };
            signing = {
              signByDefault = true;
              key = "key::sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHnLWTS5/vPyPFY+tCVYn3Ejf3NQpQzcGnWLQTyE7lbzAAAAC3NzaDpwYXNzZm94";
            };
          }
        );
      };
    };
}
