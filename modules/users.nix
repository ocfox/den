{
  flake.modules.nixos.users =
    { lib, config, ... }:
    {
      options = {
        my.name = lib.mkOption {
          type = lib.types.str;
          default = "ocfox";
          description = "The primary user for this configuration.";
        };

        my.config = lib.mkOption {
          type = with lib.types; attrsOf (attrsOf path);
          default = { };
          description = "Declarative dotfile management for the user, mapping directly to ~/.config/";
        };

        my.packages = lib.mkOption {
          type = with lib.types; listOf package;
          default = [ ];
          description = "A list of packages to be installed for the primary user.";
        };
      };

      config = lib.mkMerge [
        {
          # This is where we generate the tmpfiles rules from the new option
          systemd.tmpfiles.rules = lib.flatten (
            lib.mapAttrsToList (
              appName: files:
              let
                user = config.my.name;
                targetDir = "/home/${user}/.config/${appName}";
              in
              [ "d ${targetDir} - ${user} ${user} - -" ]
              ++ (lib.mapAttrsToList (
                fileName: source: "L+ ${targetDir}/${fileName} - ${user} ${user} - ${source}"
              ) files)
            ) config.my.config
          );
        }
        {
          # The actual user definitions remain here
          my.name = "ocfox"; # Set the value for the option

          users.users.${config.my.name} = {
            packages = config.my.packages; # Assign the collected packages here
          };

          users = {
            mutableUsers = false;
            users = {
              root.isSystemUser = true;
              ocfox = {
                isNormalUser = true;
                hashedPassword = "$6$jVI2tdENaEqUyZGh$rni.joO5US9t9RYM9wlIvia4L1YOObs44Kt3gBcooBJTeSFGyEorciM2CrKMEnzbojpi1KgPPe256i5Q46N1d0";
                openssh.authorizedKeys.keys = [
                  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHysCjoqwXAumW+cUCcFZDpC9yLx3Jh7x5du7r21fPE4"
                  "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIHnLWTS5/vPyPFY+tCVYn3Ejf3NQpQzcGnWLQTyE7lbzAAAAC3NzaDpwYXNzZm94 ssh:passfox"
                ];
                extraGroups = [
                  "adbusers"
                  "wheel"
                  "podman"
                  "networkmanager"
                  "realtime"
                  "dialout"
                  "libvirtd"
                ];
              };
            };
          };

          services.userborn.enable = true;
        }
      ];
    };
}
