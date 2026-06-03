{ config, ... }:
{
  configurations.nixos.dobby.module = {
    networking = {
      hostName = "dobby";
      hostId = "abf835ae";
      domain = "local";
    };

    hardware.facter.reportPath = ./facter.json;
    services.openssh.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINH9fDYNQ6RTHc2eGvUOjp6HZm5vXr4ofTr+b9vRpc+T";
    system.stateVersion = "24.11";

    imports = with config.flake.modules.nixos; [
      efi
      pc
      nvidia-gpu
      bow
    ];

    hardware.nvidia.open = false;
  };
}
