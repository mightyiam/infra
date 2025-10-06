{
  config,
  ...
}:
{
  perSystem =
    { inputs', pkgs, ... }:
    {
      packages.nixvim = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
        inherit pkgs;
        module = config.flake.modules.nixvim.base;
      };
    };
}
