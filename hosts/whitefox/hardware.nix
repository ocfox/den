{ config
, lib
, pkgs
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d666a5ff-d7d0-4883-a5dc-5e7b8bd7845e";
    fsType = "ext4";
  };

  fileSystems."/run/mount/win" = {
    device = "/dev/disk/by-uuid/B86695766695365A";
    fsType = "ntfs3";
    options = [ "rw" "uid=1000" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/EEE9-4D3C";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/acedeff6-cdcd-473f-b347-a74409bed8ee"; }
  ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.opengl.enable = true;
}
