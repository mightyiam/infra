{
  boot.kernelParams = ["nohibernate"];
  boot.loader.grub.zfsSupport = true;
  boot.zfs = {
    forceImportAll = false;
    forceImportRoot = false;
  };
  networking.hostId = "2a489baf";
  services.zfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };
}
