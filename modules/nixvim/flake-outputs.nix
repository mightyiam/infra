{
  config,
  nixvim,
  ...
}:
{
  perSystem =
    { system, ... }:
    {
      packages.nixvim =
        nixvim.evalNixvim {
          inherit system;
          modules = [ config.flake.modules.nixvim.base ];
        }
        |> (evaluation: evaluation.config.build.package);
    };
}
