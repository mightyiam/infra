{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.shotman
        pkgs.grimblast
      ];

      wayland.windowManager.hyprland.settings.bind = [
        "SUPER+SHIFT, w, exec, ${lib.getExe pkgs.grimblast} copy active"
        "SUPER+SHIFT, o, exec, ${lib.getExe pkgs.grimblast} copy output"
        "SUPER+SHIFT, r, exec, ${lib.getExe pkgs.grimblast} copy area"
      ];
    };
}
