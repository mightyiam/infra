{ lib, ... }:
{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    let
      package = pkgs.rofi-rbw-wayland;
    in
    {
      home.packages = [ package ];

      xdg.configFile."rofi-rbw.rc".text = lib.generators.toINIWithGlobalSection { } {
        # https://github.com/fdw/rofi-rbw#configuration
        globalSection = { };
      };

      wayland.windowManager.hyprland.settings.bind = [
        "SUPER, m, exec, ${lib.getExe package}"
      ];
    };
}
