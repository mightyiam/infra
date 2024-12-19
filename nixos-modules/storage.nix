{
  boot.zfs.forceImportRoot = false;
  services.zfs.autoScrub.enable = true;
  services.zfs.autoScrub.interval = "monthly";

  fileSystems."/" = {
    device = "storage/root";
    fsType = "zfs";
  };
}
