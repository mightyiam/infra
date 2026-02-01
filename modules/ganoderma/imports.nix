{ config, ... }:
{
  configurations.nixos.ganoderma.module = {
    imports = with config.flake.modules.nixos; [
      efi
      nvidia-gpu
      swap
      workstation
    ];
  };
}
