{ config, ... }:
{
  flake.modules.nixos."nixosConfigurations/ganoderma".imports = with config.flake.modules.nixos; [
    efi
    workstation
    nvidia-gpu
    swap
    mobile-device
  ];
}
