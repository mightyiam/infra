{lib, ...}: {
  nixos.modules.base = nixosArgs: {
    options = {
      swap.partlabels = lib.mkOption {
        type = lib.types.listOf lib.types.singleLineStr;
      };
    };

    config = {
      assertions = [
        # TODO has swap devices
      ];

      swapDevices =
        nixosArgs.config.swap.partlabels
        |> map (partlabel: {
          device = "/dev/disk/by-partlabel/${partlabel}";
          randomEncryption.enable = true;
        });
    };
  };
}
