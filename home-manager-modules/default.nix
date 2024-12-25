{ lib, util, ... }:
{
  options.flake.homeManagerModules = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
  };
  config.flake.homeManagerModules = util.readModulesDir ./.;
}
