{ config, ... }:
{
  flake.modules.nixos.workstation.imports = with config.flake.modules.nixos; [ desktop ];
}
