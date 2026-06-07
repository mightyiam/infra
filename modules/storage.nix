{lib, ...}: {
  nixos.modules.base = nixosArgs @ {pkgs, ...}: {
    options = {
      swap.partlabels = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
      };
      boot.partlabels = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
        apply = map (partlabel: {
          inherit partlabel;
          path = "/${partlabel}";
        });
      };
    };

    config = {
      assertions = [
        # TODO has swap devices
      ];

      fileSystems = lib.mkMerge [
        {
          "/" = {
            device = "storage/root";
            fsType = "zfs";
          };
        }
        (
          nixosArgs.config.boot.partlabels
          |> map (
            {
              path,
              partlabel,
            }: {
              name = path;
              value = {
                device = "/dev/disk/by-partlabel/${partlabel}";
                fsType = "vfat";
                options = [
                  "fmask=0022"
                  "dmask=0022"
                ];
              };
            }
          )
          |> lib.listToAttrs
        )
      ];

      swapDevices =
        nixosArgs.config.swap.partlabels
        |> map (partlabel: {
          device = "/dev/disk/by-partlabel/${partlabel}";
          randomEncryption.enable = true;
        });

      boot = {
        zfs.forceImportRoot = false;
        tmp.cleanOnBoot = true;

        loader.grub.mirroredBoots =
          nixosArgs.config.boot.partlabels
          |> map (
            {path, ...}: {
              inherit path;
              devices = ["nodev"];
            }
          );
      };

      services.zfs.autoScrub = {
        enable = true;
        interval = "monthly";
      };

      environment.systemPackages = [pkgs.gptfdisk];
    };
  };
}
