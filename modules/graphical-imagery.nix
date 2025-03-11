{ lib, ... }:
{
  flake.modules.homeManager.home =
    {
      pkgs,
      config,
      ...
    }:
    lib.mkMerge [
      (lib.mkIf config.gui.enable {
        home.packages = with pkgs; [
          gimp
          imv
          inkscape
        ];
        xdg.mimeApps.defaultApplications =
          [
            "image/png"
            "image/jpeg"
          ]
          |> map (lib.flip lib.nameValuePair [ "imv.desktop" ])
          |> lib.listToAttrs;
      })
    ];
}
