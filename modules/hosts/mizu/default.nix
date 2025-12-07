{ config, ... }:
let
  inherit (config.flake.lib) mkHostModule;
in
{
  flake.modules.nixos.mizu =
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
            boot.initrd.availableKernelModules = [
              "ata_piix"
              "uhci_hcd"
              "virtio_pci"
              "virtio_scsi"
              "ehci_pci"
              "xhci_pci"
              "sr_mod"
              "virtio_blk"
              "ahci"
              "xen_blkfront"
              "vmw_pvscsi"
            ];
            boot.initrd.kernelModules = [ ];
            boot.kernelModules = [ "kvm-amd" ];
            boot.extraModulePackages = [ ];

            fileSystems."/" = {
              device = "/dev/disk/by-uuid/580fd907-a2af-478d-adf1-7a70edcca3be";
              fsType = "ext4";
            };

            environment.systemPackages = [
              pkgs.hysteria
              pkgs.tmux
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
              nameservers = [
                "1.1.1.1"
                "8.8.8.8"
                "2606:4700:4700::1111"
                "2001:4860:4860::8888"
              ];
            };

            boot.loader.grub.enable = true;
            boot.loader.grub.device = "/dev/vda";
            swapDevices = [
              {
                device = "/swapfile";
                size = 1175;
              }
            ];
            boot.kernelParams = [
              "console=ttyS0,115200n8"
              "console=tty0"
            ];
            services.openssh.enable = true;
            boot.kernel.sysctl."net.ipv6.conf.eth0.accept_ra" = false;
            boot.kernel.sysctl."net.ipv6.conf.eth0.autoconf" = false;

            imports = [
              (modulesPath + "/profiles/qemu-guest.nix")
            ];
          }
        ];
      };
    };
}
