{
  config,
  ...
}:
{
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
        module = config.flake.modules.nixvim.astrea;
      };

      checks."packages/nixvim" = self'.packages.nixvim;
    };
}
