{ config, ... }:
{
  configurations.nixos.termitomyces.module = {
    imports = with config.flake.modules.nixos; [
      efi
      pc
    ];
  };
}
