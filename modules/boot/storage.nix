{ lib, ... }:
{
  flake.modules.nixos.desktop = nixosArgs: {
    boot.loader.grub.mirroredBoots =
      nixosArgs.config.storage.redundancy.range
      |> map (i: [
        {
          devices = [ "nodev" ];
          path = "/boot${i}";
        }
      ])
      |> lib.mkMerge;

    fileSystems =
      nixosArgs.config.storage.redundancy.range
      |> map (i: {
        "/boot${i}" = {
          device = "/dev/disk/by-partlabel/boot${i}";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      })
      |> lib.mkMerge;
  };
}
