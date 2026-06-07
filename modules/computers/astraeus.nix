{config, ...}: {
  nixos.configurations.astraeus.module = {
    networking.hostId = "5ddc3c42";
    system.stateVersion = "25.11";
    hardware.facter.reportPath = ./astraeus.facter.json;
    services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIYvXn67X8v5UbC1STan+yUVC7xoCPuYn0V/m8qgt4hy root@astraeus";
    boot.partlabels = ["boot0"];

    imports = with config.nixos.modules; [
      efi
      pc
    ];
  };
}
