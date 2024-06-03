{
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkIf
    ;
in
  mkIf config.gui.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        live_config_reload = true;
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
  }
