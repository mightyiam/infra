{ config, ... }:
{
  configurations.nixos.astraeus.module = {
    networking = {
      hostName = "astraeus";
      hostId = "5ddc3c42";
    };

    system.stateVersion = "25.11";
    hardware.facter.reportPath = ./facter.json;
    services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIYvXn67X8v5UbC1STan+yUVC7xoCPuYn0V/m8qgt4hy root@astraeus";

    imports = with config.flake.modules.nixos; [
      efi
      pc
    ];

    storage.redundancy.count = 1;
  };
}
