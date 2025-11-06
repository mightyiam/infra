{
  perSystem =
    { inputs', ... }:
    {
      treefmt.programs = {
        nixf-diagnose.enable = true;

        statix = {
          enable = true;
          package = inputs'.statix.packages.default;
        };
      };
    };
}
