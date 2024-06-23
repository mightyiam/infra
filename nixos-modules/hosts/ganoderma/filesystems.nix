{
  fileSystems = {
    "/" = {
      device = "storage";
      fsType = "zfs";
    };

    "/boot1" = {
      device = "/dev/disk/by-uuid/2413-5251";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    "/boot0" = {
      device = "/dev/disk/by-uuid/2414-200F";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
}
