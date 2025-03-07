{ lib, ... }:
{
  flake.modules.homeManager.home.options.gui.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
  };
}
