{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = ["amdgpu.dcfeaturemask=0x8"];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=8G" "mode=755" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4B1C-DEA2";
      fsType = "vfat";
    };

  fileSystems."/nix" =
    { device = "rpool/local/nix";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

  fileSystems."/home" =
    { device = "rpool/local/home";
      fsType = "zfs";
      options = [ "zfsutil" ];
    };

  fileSystems."/persist" =
    { device = "rpool/safe/persist";
      fsType = "zfs";
      options = [ "zfsutil" ];
      neededForBoot = true;
    };

  fileSystems."/tmp" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=32G" "mode=1777" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.opengl.driSupport = true;
  
}

