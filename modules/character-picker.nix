{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    let
      inherit (pkgs) rofimoji;
    in
    {
      home.packages = [ rofimoji ];

      wayland.windowManager.hyprland.settings.bind = [
        "SUPER, u, exec, ${lib.getExe rofimoji}"
        "SUPER+Shift, u, exec, ${lib.getExe rofimoji} --files all"
      ];
    };
}
