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
  nixos.modules.base = {
    config = {
      fileSystems."/" = {
        device = "storage/root";
        fsType = "zfs";
      };

      boot.zfs.forceImportRoot = false;

      services.zfs.autoScrub = {
        enable = true;
        interval = "monthly";
      };
    };
  };
}
