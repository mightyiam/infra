{ config, lib, ... }:
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

  config = lib.mkIf config.gui.enable {
    terminal = {
      path = lib.getExe config.programs.alacritty.package;
      withTitle = cmd: "${config.terminal.path} --title ${cmd} --command ${cmd}";
    };

    programs.alacritty = {
      enable = true;
      settings = {
        general.live_config_reload = true;
        window = {
          decorations = "none";
          dynamic_title = true;
          opacity = config.style.windowOpacity;
          title = "Terminal";
        };
        bell = {
          duration = builtins.ceil config.style.bellDuration;
          color = "#000000";
        };
      };
    };

    wayland.windowManager.sway.config = {
      terminal = config.terminal.path;
      keybindings = {
        "Mod4+Return" = null;
        "--no-repeat Mod4+Return" = "exec ${lib.getExe config.programs.alacritty.package}";
      };
    };
  };
}
