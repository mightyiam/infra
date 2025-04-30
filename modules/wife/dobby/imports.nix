{ config, ... }:
{
  flake.modules.nixos."nixosConfigurations/dobby".imports = with config.flake.modules.nixos; [
    efi
    pc
    nvidia-gpu
    wife
  ];
}
