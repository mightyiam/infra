{ config, ... }:
{
  configurations.nixos.ganoderma.module = {
    imports = with config.flake.modules.nixos; [
      efi
      workstation
      nvidia-gpu
      swap
    ];
  };
}
