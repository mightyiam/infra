{ config, ... }:
{
  configurations.nixos.dobby.modules = with config.flake.modules.nixos; [
    efi
    pc
    nvidia-gpu
    wife
  ];
}
