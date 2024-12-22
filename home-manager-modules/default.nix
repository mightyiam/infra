{ self, lib, ... }:
{
  options.flake.homeManagerModules = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
  };
  config.flake.homeManagerModules = self.lib.readModulesDir ./.;
}
