{lib, ...}: {
  nixos.modules = {
    base = nixosArgs: {
      options.boot.partlabels = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
        apply = map (partlabel: {
          inherit partlabel;
          path = "/${partlabel}";
        });
      };

      config = {
        boot = {
          kernelParams = [
            "quiet"
            "systemd.show_status=error"
          ];

          loader.grub.mirroredBoots =
            nixosArgs.config.boot.partlabels
            |> map (
              {path, ...}: {
                inherit path;
                devices = ["nodev"];
              }
            );
        };

        fileSystems =
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
          |> lib.listToAttrs;
      };
    };

    pc = {
      boot.plymouth.enable = true;
    };
  };
}
