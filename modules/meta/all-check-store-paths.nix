{ lib, ... }:
{
  perSystem =
    { pkgs, self', ... }:
    let
      pkgName = "all-check-store-paths";
    in
    {
      packages.${pkgName} =
        self'.checks
        |> lib.filterAttrs (name: drv: name != "packages/${pkgName}")
        |> lib.mapAttrs (name: drv: builtins.unsafeDiscardStringContext drv)
        |> pkgs.writers.writeTOML "${pkgName}.toml";
    };
}
