{
  lib,
  config,
  self,
  util,
  ...
}:
{
  config = {
    flake.modules.nixvim = util.readModulesDir ./.;
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
          module.imports = lib.attrValues config.flake.modules.nixvim;
        };

        checks."packages/nixvim" = self'.packages.nixvim;
      };
  };
}
