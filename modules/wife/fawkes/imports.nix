{ config, ... }:
{
  configurations.nixos.fawkes.module = {
    imports = with config.flake.modules.nixos; [
      efi
      pc
      wife
    ];
  };
}
