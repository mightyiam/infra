{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        exiftool
        gimp-with-plugins
        imagemagick
        imv
        inkscape
        jpeginfo
        wl-color-picker
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
