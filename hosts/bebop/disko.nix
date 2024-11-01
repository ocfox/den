{
  devices = {
    disk = {
      nvme1 = {
        type = "disk";
        device = "/dev/disk/by-path/pci-0000:01:00.0-nvme-1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "ESP";
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/efi";
                mountOptions = [ "umask=0077" ];
              };
            };

            root = {
              size = "100%";
              content = {
                type = "btrfs";
                subvolumes =
                  let
                    mountOptions = [
                      "compress=zstd"
                      "discard=async"
                      "noatime"
                    ];
                  in
                  {
                    "/root" = {
                      mountpoint = "/";
                      inherit mountOptions;
                    };
                    "/home" = {
                      mountpoint = "/home";
                      inherit mountOptions;
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      inherit mountOptions;
                    };

                    "/swap" = {
                      mountpoint = "/.swap";
                      swap.swapfile.size = "32G";
                    };
                  };
              };
            };
          };
        };
      };
    };
  };
}
