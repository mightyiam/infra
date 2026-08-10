/*
storage:
  mounpoint: legacy
  compression: zstd-3 (or a lower integer for slower CPUs)
  atime: off
  xattr: off
  acltype: off
  encryption: on
  keyformat: passphrase
  keylocation: prompt

storage/root:
  quota: depends on volume
*/
{
  nixos.modules.base = {pkgs, ...}: {
    config = {
      fileSystems."/" = {
        device = "storage/root";
        fsType = "zfs";
      };

      boot = {
        zfs.forceImportRoot = false;
        tmp.cleanOnBoot = true;
      };

      services.zfs.autoScrub = {
        enable = true;
        interval = "monthly";
      };

      environment.systemPackages = [pkgs.gptfdisk];
    };
  };
}
