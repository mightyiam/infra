{ self, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
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
    };
}
