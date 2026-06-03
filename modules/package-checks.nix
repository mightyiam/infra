{ lib, ... }:
{
  perSystem =
    { self', ... }:
    {
      checks =
        self'.packages
        |> lib.filterAttrs (name: package: package.flakeCheck or true)
        |> lib.mapAttrs' (name: drv: lib.nameValuePair "packages/${name}" drv);
    };
}
