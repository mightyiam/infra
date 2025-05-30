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

        extraConfig = ''
          submap = ${submap}
          binde = , n, exec, ${wpaperctl} next-wallpaper
          binde = , p, exec, ${wpaperctl} previous-wallpaper
          ${hmArgs.config.wayland.windowManager.hyprland.submapEnd}
          bind = SUPER, b, submap, ${submap}
        '';
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
