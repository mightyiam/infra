{ lib, withSystem, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    let
      sink-rotate = withSystem pkgs.stdenv.hostPlatform.system (
        { inputs', ... }: inputs'.sink-rotate.packages.default
      );
    in
    {
      home.packages = [ sink-rotate ];
      wayland.windowManager.hyprland.settings.bind = [
        "SUPER, c, exec, ${lib.getExe sink-rotate}"
      ];
    };
}
