{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.telegram-desktop ];
      xdg.mimeApps.defaultApplications =
        [
          "x-scheme-handler/tg"
          "x-scheme-handler/tonsite"
        ]
        |> map (type: lib.nameValuePair type [ "org.telegram.desktop.desktop" ])
        |> lib.listToAttrs;
    };
}
