{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        exiftool
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
    };
}
