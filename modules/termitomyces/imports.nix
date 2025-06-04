{ config, ... }:
{
  configurations.nixos.termitomyces.modules = with config.flake.modules.nixos; [
    efi
    workstation
  ];
}
