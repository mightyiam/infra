{ config, ... }:
{
  flake.modules.nixos."nixosConfigurations/ganoderma".imports = with config.flake.modules.nixos; [
    desktop
    nvidia-gpu
    swap
    virtualbox
  ];
}
