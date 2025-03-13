{ config, ... }:
{
  flake.modules.nixos."nixosConfigurations/dobby".imports = with config.flake.modules.nixos; [
    desktop
    nvidia-gpu
    wife
  ];
}
