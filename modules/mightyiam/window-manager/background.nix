{lib, ...}: {
  home.gui = hmArgs: let
    wpaperctl = lib.getExe' hmArgs.config.services.wpaperd.package "wpaperctl";
  in {
    wayland.windowManager.hyprland = {
      settings.misc.disable_hyprland_logo = true;

      settings.bind = [
        "SUPER, i, exec, ${wpaperctl} next-wallpaper"
        "SUPER+SHIFT, i, exec, ${wpaperctl} previous-wallpaper"
      ];
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
