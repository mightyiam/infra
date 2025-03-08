{ config, ... }:
{
  flake.modules.nixos."nixosConfigurations/ganoderma".imports = with config.flake.modules.nixos; [
    workstation
    nvidia-gpu
    swap
  ];
}
