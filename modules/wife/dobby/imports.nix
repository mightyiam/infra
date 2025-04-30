{ config, ... }:
{
  flake.modules.nixos."nixosConfigurations/dobby".imports = with config.flake.modules.nixos; [
    efi
    desktop
    nvidia-gpu
    wife
  ];
}
