{ lib, ... }:
{
  flake.modules.nixos.base =
    { config, ... }:
    {
      options.storage.redundancy = {
        count = lib.mkOption {
          type = lib.types.int;
          default = 2;
        };
        range = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = config.storage.redundancy.count |> lib.flip lib.sub 1 |> lib.range 0 |> map toString;
        };
      };
    };

}
