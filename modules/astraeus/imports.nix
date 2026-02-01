{ config, ... }:
{
  configurations.nixos.astraeus.module = {
    imports = with config.flake.modules.nixos; [
      efi
      pc
    ];
  };
}
