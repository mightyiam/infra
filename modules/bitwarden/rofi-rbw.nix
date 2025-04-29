{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    let
      package = pkgs.rofi-rbw-wayland;
    in
    {
      home.packages = [ package ];

      xdg.configFile."rofi-rbw.rc".text = lib.generators.toINIWithGlobalSection { } {
        # https://github.com/fdw/rofi-rbw#configuration
        globalSection = { };
      };

      wayland.windowManager.sway.config.keybindings =
        let
          mod = hmArgs.config.wayland.windowManager.sway.config.modifier;
        in
        {
          "--no-repeat ${mod}+m" = "exec ${lib.getExe package}";
        };
    };
}
