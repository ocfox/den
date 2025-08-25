{ config, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-amd" ];

  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  hardware.enableRedistributableFirmware = true;
}
