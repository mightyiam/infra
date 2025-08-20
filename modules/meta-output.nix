{ lib, ... }:
{
  options.flake.meta = lib.mkOption {
    type = lib.types.anything;
  };
}
