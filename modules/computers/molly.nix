{config, ...}: {
  nixos.configurations.molly = {
    module = nixosArgs: {
      imports = [
        config.nixos.modules.base
        config.users.mightyiam.nixos.base
      ];

      boot = {
        initrd.availableKernelModules = [
          "virtio_scsi" # TODO ideally a facter module does this
        ];

        loader.grub.device = "/dev/sda";
      };

      fileSystems = {
        "/" = {
          device = "/dev/sda2";
          fsType = "ext4";
        };
      };

      networking = {
        hostName = "nixpkgs";
        domain = "molybdenum.software";
      };

      system.stateVersion = "25.05";
    };

    facter.reportPath = ./molly.facter.json;
  };
}
