{ config, ... }:
{
  configurations.nixos.ganoderma.module = {
    networking = {
      hostName = "ganoderma";
      hostId = "0e8e163d";
      domain = "local";
    };

    system.stateVersion = "24.11";
    services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBc+R3LtvYs/encp9UIqWKoKDG7Zr448LwIYs2nrao7+";
    hardware.facter.reportPath = ./facter.json;

    hardware.nvidia.open = false;

    imports = with config.flake.modules.nixos; [
      efi
      nvidia-gpu
      pc
      swap
      bow
    ];
  };
}
