{ config, ... }:
{
  flake.modules.nixvim.base = {
    nixpkgs.overlays = config.nixpkgs.overlays;
  };
}
