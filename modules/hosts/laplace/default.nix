{ inputs, config, ... }:
let
  inherit (config.flake.lib) mkHostModule;
  nixosModules = config.flake.modules.nixos;
in
{
  flake.modules.nixos.laplace =
    {
      pkgs,
      modulesPath,
      lib,
      config,
      ...
    }:
    {
      imports = mkHostModule {
        stateVersion = "25.11";
        nixosModules = with nixosModules; [
          facter
          disko
        ];
        hostKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID8IVBgnE6cfei0k4va0fyzyoh9o62f9yM3FwGhnPJON";
        extraModules = [
          { facter.reportPath = ./facter.json; }
          {
            vaultix = {
              secrets.drive = {
                file = inputs.self + "/secrets/drive.age";
                mode = "640";
              };
              secrets.vault = {
                file = inputs.self + "/secrets/vault.age";
                mode = "640";
              };
            };
          }
          {
            fileSystems."/var/lib/immich/library" = {
              device = "immich:immich";
              fsType = "rclone";
              options =
                let
                  configPath = config.vaultix.secrets.drive.path;
                in
                [
                  "nodev"
                  "nofail"
                  "allow_other"
                  "args2env"
                  "vfs-cache-mode=writes"
                  "config=${configPath}"
                ];
            };

          }
          {
            security.acme.defaults.email = "civet@ocfox.me";
            security.acme.acceptTerms = true;

            boot.loader.grub = {
              efiSupport = true;
              efiInstallAsRemovable = true;
            };

            boot.initrd = {
              compressor = "zstd";
              compressorArgs = [
                "-19"
                "-T0"
              ];
              systemd.enable = true;
            };

            services = {
              immich.enable = true;

              vaultwarden = {
                enable = true;
                config = {
                  SMTP_SECURITY = "starttls";
                  SMTP_PORT = 587;
                  SMTP_HOST = "smtp.migadu.com";
                  SMTP_FROM = "vault@cyans.dev";
                  SMTP_USERNAME = "vault@cyans.dev";
                  DOMAIN = "https://vault.cyans.dev";
                };
                environmentFile = config.vaultix.secrets.vault.path;
              };

              caddy = {
                enable = true;
                email = "chi@ocfox.me";

                virtualHosts = {
                  "vault" = {
                    hostName = "vault.cyans.dev";
                    extraConfig = ''
                      reverse_proxy localhost:8000 {
                        header_up X-Real-IP {remote_host}
                      }
                    '';
                  };

                  "immich" = {
                    hostName = "immich.ocfox.me";
                    extraConfig = ''
                      reverse_proxy localhost:2283
                    '';
                  };
                };
              };
            };
            networking = {
              firewall = {
                enable = false;
              };

              useDHCP = false;
            };
            systemd.network = {
              enable = true;
              networks = {
                "eth0" = {
                  matchConfig.MACAddress = "96:00:04:4e:89:6d";
                  address = [
                    "94.130.74.166/32"
                    "2a01:4f8:1c1c:dd43::1/64"
                  ];
                  routes = [
                    { Gateway = "fe80::1"; }
                    {
                      Gateway = "172.31.1.1";
                      GatewayOnLink = true;
                    }
                  ];
                  linkConfig.RequiredForOnline = "routable";
                };
              };
            };
          }
        ];
      };
    };
}
