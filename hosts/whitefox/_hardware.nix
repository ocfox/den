{ config
, lib
, modulesPath
, pkgs
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/0ca7545c-30e4-4f9a-b3ed-dde411aa6084";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/29E1-98CC";
      fsType = "vfat";
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/baced005-ee3c-4db1-b466-2d7fabdc3970"; }];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
