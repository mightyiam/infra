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
  nixos.modules.base = nixosArgs @ {pkgs, ...}: {
    options = {
      swap.partlabels = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
      };
    };

    config = {
      assertions = [
        # TODO has swap devices
      ];

      fileSystems."/" = {
        device = "storage/root";
        fsType = "zfs";
      };

      swapDevices =
        nixosArgs.config.swap.partlabels
        |> map (partlabel: {
          device = "/dev/disk/by-partlabel/${partlabel}";
          randomEncryption.enable = true;
        });

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
