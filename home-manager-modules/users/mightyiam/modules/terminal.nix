{ config, lib, ... }:
{
  options.terminal = lib.mkOption {
    type = lib.types.package;
    default = null;
  };

  config = lib.mkIf config.gui.enable {
    terminal = config.programs.alacritty.package;

    programs.alacritty = {
      enable = true;
      settings = {
        general.live_config_reload = true;
        window.decorations = "none";
        window.dynamic_title = true;
        window.opacity = config.style.windowOpacity;
        window.title = "";
        bell = {
          duration = builtins.ceil config.style.bellDuration;
          color = "#000000";
        };
      };
    };

    wayland.windowManager.sway.config.keybindings."--no-repeat Mod4+Return" = "exec ${lib.getExe config.terminal}";
  };
}
