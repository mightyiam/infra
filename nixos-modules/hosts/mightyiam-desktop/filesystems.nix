{
  fileSystems = {
    "/" = {
      device = "nixos/root";
      fsType = "zfs";
    };

    "/etc" = {
      device = "nixos/root/etc";
      fsType = "zfs";
    };

    "/nix" = {
      device = "nixos/root/nix";
      fsType = "zfs";
    };

    "/var" = {
      device = "nixos/root/var";
      fsType = "zfs";
    };

    "/bin" = {
      device = "nixos/root/bin";
      fsType = "zfs";
    };

    "/home" = {
      device = "nixos/root/home";
      fsType = "zfs";
    };

    "/root" = {
      device = "nixos/root/root";
      fsType = "zfs";
    };

    "/sbin" = {
      device = "nixos/root/sbin";
      fsType = "zfs";
    };

    "/boot1" = {
      device = "/dev/disk/by-uuid/82EC-9017";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    "/boot0" = {
      device = "/dev/disk/by-uuid/816E-3CD9";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };
  };
}
