{ config, lib, ... }:
{
  perSystem =
    { pkgs, self', ... }:
    {
      packages.drv-paths =
        config.flake.nixosConfigurations
        |> lib.attrValues
        |> map (
          lib.getAttrFromPath [
            "config"
            "system"
            "build"
            "toplevel"
            "drvPath"
          ]
        )
        |> map builtins.unsafeDiscardStringContext
        |> lib.concatStringsSep "\n"
        |> (pkgs.writeText "drv-paths");

      checks.drv-paths = self'.packages.drv-paths;
    };
}
