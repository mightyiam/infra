{
  fileSystems = {
    "/" = {
      device = "storage/root";
      fsType = "zfs";
    };

    "/boot0" = {
      device = "/dev/disk/by-partlabel/boot0";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    "/boot1" = {
      device = "/dev/disk/by-partlabel/boot1";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
}
