{ self, lib, ... }:
{
  perSystem =
    { pkgs, config, ... }:
    {
      packages.drv-paths =
        self.nixosConfigurations
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

      checks.drv-paths = config.packages.drv-paths;
    };
}
