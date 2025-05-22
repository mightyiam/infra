{ lib, ... }:
{
  flake.modules.homeManager = {
    base =
      { pkgs, ... }:
      {
        options.terminal = {
          path = lib.mkOption {
            type = lib.types.path;
            default = null;
          };
          withTitle = lib.mkOption {
            type = lib.types.functionTo lib.types.str;
            default = null;
          };
        };

        config.home.packages = with pkgs; [ ansifilter ];
      };
    gui =
      hmArgs@{ pkgs, ... }:
      {
        terminal = {
          path = lib.getExe hmArgs.config.programs.alacritty.package;
          withTitle = cmd: "${hmArgs.config.terminal.path} --title ${cmd} --command ${cmd}";
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

        wayland.windowManager.sway.config = {
          terminal = hmArgs.config.terminal.path;
          keybindings = {
            "Mod4+Return" = null;
            "--no-repeat Mod4+Return" = "exec ${lib.getExe hmArgs.config.programs.alacritty.package}";
            "--no-repeat Mod4+Shift+Return" =
              "exec ${lib.getExe hmArgs.config.programs.alacritty.package} --working-directory `${lib.getExe pkgs.swaycwd}`";
          };
        };
      };
  };
}
