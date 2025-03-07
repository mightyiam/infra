{ config, ... }:
{
  flake.modules.nixos."nixosConfigurations/ganoderma" = {
    imports = with config.flake.modules.nixos; [ facter ];
    facter.reportPath = ./facter.json;
  };
}
