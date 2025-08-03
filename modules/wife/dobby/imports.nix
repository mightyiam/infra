{ config, ... }:
{
  configurations.nixos.dobby.module = {
    imports = with config.flake.modules.nixos; [
      efi
      pc
      nvidia-gpu
      wife
    ];
  };
}
