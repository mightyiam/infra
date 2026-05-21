{
  config,
  ...
}:
{
  perSystem =
    { inputs', ... }:
    {
      packages.nixvim = inputs'.nixvim.legacyPackages.makeNixvim config.flake.modules.nixvim.base;
    };
}
