{
  flake.modules.homeManager.gui = hmArgs: {
    wayland.windowManager.hyprland.settings.misc.disable_hyprland_logo = true;

    services.wpaperd = {
      enable = true;
      settings.default = {
        path = "${hmArgs.config.home.homeDirectory}/backgrounds";
        duration = "4h";
        sorting = "random";
        mode = "center";
      };
    };
  };
}
