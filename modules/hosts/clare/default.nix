{ config, ... }:
let
  inherit (config.flake.lib) mkHostModule;
in
{
  flake.modules.nixos.clare =
    {
      pkgs,
      modulesPath,
      lib,
      ...
    }:
    {
      imports = mkHostModule {
        stateVersion = "25.11";
        modules = [
          {
            boot.loader.grub.enable = true;
            boot.loader.grub.device = "/dev/vda";
            swapDevices = [
              {
                device = "/swapfile";
                size = 69;
              }
            ];
            boot.kernelParams = [
              "console=ttyS0,115200n8"
              "console=tty0"
            ];
            networking = {
              firewall.enable = false;
              nftables = {
                enable = true;
                ruleset = ''
                  define INGRESS_INTERFACE="eth0"
                  define PORT_RANGE=20000-50000
                  define HYSTERIA_SERVER_PORT=443

                  table inet hysteria_porthopping {
                    chain prerouting {
                      type nat hook prerouting priority dstnat; policy accept;
                      iifname $INGRESS_INTERFACE udp dport $PORT_RANGE counter redirect to :$HYSTERIA_SERVER_PORT
                    }
                  }
                '';
              };
              usePredictableInterfaceNames = false;
              interfaces.eth0.ipv4.addresses = [
                {
                  address = "154.17.16.142";
                  prefixLength = 32;
                }
              ];
              defaultGateway = {
                address = "193.41.250.250";
                interface = "eth0";
              };
              nameservers = [
                "1.1.1.1"
                "8.8.8.8"
                "2606:4700:4700::1111"
                "2001:4860:4860::8888"
              ];
            };

            imports = [
              (modulesPath + "/profiles/qemu-guest.nix")
            ];

            boot.initrd.availableKernelModules = [
              "uhci_hcd"
              "ehci_pci"
              "ahci"
              "virtio_pci"
              "sr_mod"
              "virtio_blk"
              "ata_piix"
              "xen_blkfront"
              "vmw_pvscsi"
            ];
            boot.initrd.kernelModules = [ ];
            boot.kernelModules = [ "kvm-amd" ];
            boot.extraModulePackages = [ ];

            fileSystems."/" = {
              device = "/dev/disk/by-uuid/abf81274-ce56-4d1e-a613-b41aecf48ac8";
              fsType = "ext4";
            };

          }
        ];
      };
    };
}
