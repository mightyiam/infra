{ lib, ... }:
{
  options.pinentry = lib.mkOption {
    type = lib.types.package;
  };
}
