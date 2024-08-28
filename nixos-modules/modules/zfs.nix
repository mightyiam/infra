{config, ...}: {
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.zfs.forceImportRoot = false;
  services.zfs.autoScrub.enable = true;
  services.zfs.autoScrub.interval = "monthly";
}
