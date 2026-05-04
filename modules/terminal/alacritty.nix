{ lib, ... }:
{
  flake.modules.homeManager.gui = hmArgs: {
    terminal = {
      path = lib.getExe hmArgs.config.programs.alacritty.package;
      desktopFileId = "Alacritty.desktop";
    };

    programs.alacritty = {
      enable = true;
      settings = {
        general.live_config_reload = true;
        window = {
          decorations = "none";
          dynamic_title = true;
          title = "Terminal";
        };
        bell = {
          # https://github.com/danth/stylix/discussions/1207
          # ideally this would be some stylix color theme color
          color = "#000000";
          duration = 200;
        };
      };
    };
  };
}
