{
  config,
  lib,
  ...
}: {
  nixos.configurations.dobby = {
    module = nixosArgs: {
      networking = {
        hostName = "dobby";
        hostId = "abf835ae";
      };

      services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINH9fDYNQ6RTHc2eGvUOjp6HZm5vXr4ofTr+b9vRpc+T";
      system.stateVersion = "24.11";

      imports =
        (with config.nixos.modules; [
          efi
          pc
          nvidia-video-driver
        ])
        |> lib.concat [
          config.users.bow.nixos.pc
        ];

      specialisation.default-video-driver.configuration = config.nixos.modules.force-default-video-drivers;

      boot.partlabels = [
        "boot0"
        "boot1"
      ];

      hardware = {
        nvidia = {
          open = false;
          package = nixosArgs.config.boot.kernelPackages.nvidiaPackages.legacy_580;
        };
      };
    };

    facter.reportPath = ./dobby.facter.json;
  };
}
