{ inputs, lib, ... }:
{
  imports = [ inputs.devshell.flakeModule ];
  perSystem =
    { self', ... }:
    {
      checks = self'.devShells |> lib.mapAttrs' (name: drv: lib.nameValuePair "devShells/${name}" drv);
    };
}
