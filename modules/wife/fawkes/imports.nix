{ config, ... }:
{
  flake.modules.nixos."nixosConfigurations/fawkes".imports = with config.flake.modules.nixos; [
    efi
    pc
    wife
  ];
}
