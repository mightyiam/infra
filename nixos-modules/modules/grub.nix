{
  fileSystems = {
    "/boot0" = {
      device = "/dev/disk/by-partlabel/boot0";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/boot1" = {
      device = "/dev/disk/by-partlabel/boot1";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };

  boot.loader.timeout = 4;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.mirroredBoots = [
    {
      devices = [ "nodev" ];
      path = "/boot0";
    }
    {
      devices = [ "nodev" ];
      path = "/boot1";
    }
  ];
  boot.loader.efi.canTouchEfiVariables = true;
}
