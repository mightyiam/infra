{
  lib,
  self,
  ...
}:
{
  options.flake.nixvimModules = lib.mkOption {
    type = lib.types.attrsOf lib.types.anything;
  };

  config = {
    flake.nixvimModules = self.lib.readModulesDir ./.;
    perSystem =
      {
        inputs',
        self',
        pkgs,
        ...
      }:
      {
        packages.nixvim = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
          inherit pkgs;
          extraSpecialArgs = {
            inherit self;
          };
          module.imports = lib.attrValues self.nixvimModules;
        };

        checks."packages/nixvim" = self'.packages.nixvim;
      };
  };
}
