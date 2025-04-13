{ inputs, lib, ... }:
{
  imports = [ inputs.make-shell.flakeModules.default ];
  perSystem =
    { self', ... }:
    {
      checks = self'.devShells |> lib.mapAttrs' (name: drv: lib.nameValuePair "devShells/${name}" drv);
    };
}
