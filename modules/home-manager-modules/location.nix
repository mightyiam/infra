{ lib, ... }:
{
  options.location = {
    latitude = lib.mkOption {
      type = lib.types.numbers.between (-90) 90;
      default = 18.746;
    };
    longitude = lib.mkOption {
      type = lib.types.numbers.between (-180) 180;
      default = 99.075;
    };
  };
}
