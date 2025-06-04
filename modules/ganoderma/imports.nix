{ config, ... }:
{
  configurations.nixos.ganoderma.modules = with config.flake.modules.nixos; [
    efi
    workstation
    nvidia-gpu
    swap
  ];
}
