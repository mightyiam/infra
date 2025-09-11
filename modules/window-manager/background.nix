{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs:
    let
      wpaperctl = lib.getExe' hmArgs.config.services.wpaperd.package "wpaperctl";
      submap = "background";
    in
    {
      wayland.windowManager.hyprland = {
        settings.misc.disable_hyprland_logo = true;

        settings.bind = [
          "SUPER, b, submap, ${submap}"
        ];

        submaps.${submap}.settings = {
          binde = [
            ", n, exec, ${wpaperctl} next-wallpaper"
            ", p, exec, ${wpaperctl} previous-wallpaper"
          ];
          bind = [
            ", escape, submap, reset"
            ", catchall, exec, true"
          ];
        };
      };

      services.wpaperd = {
        enable = true;
        settings.default = {
          path = "${hmArgs.config.home.homeDirectory}/backgrounds";
          duration = "4h";
          sorting = "random";
          queue-size = 20;
          mode = "center";
        };
      };
    };
}
