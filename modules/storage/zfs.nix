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
{lib, ...}: {
  options.nixos.modules.zfs = lib.mkOption {
    type = lib.types.deferredModule;
    readOnly = true;
    default = {
      key = "zfs";
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
