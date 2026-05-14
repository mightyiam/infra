{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.sink-rotate ];
      wayland.windowManager.hyprland.settings.bind = [
        "SUPER, c, exec, ${lib.getExe pkgs.sink-rotate}"
      ];
    };
}
