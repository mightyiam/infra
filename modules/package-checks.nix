{ lib, ... }:
{
  perSystem =
    { self', ... }:
    {
      checks = self'.packages |> lib.mapAttrs' (name: drv: lib.nameValuePair "packages/${name}" drv);
    };
}
