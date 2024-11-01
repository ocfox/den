{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-amd"
    "i915.force_probe=56a1"
    "v4l2loopback"
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fe0ecfb9-db21-43f0-915a-70c37765f181";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3307-5F4E";
    fsType = "vfat";
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-ocl
      intel-media-driver
    ];
  };

  hardware.keyboard.qmk.enable = true;
}
