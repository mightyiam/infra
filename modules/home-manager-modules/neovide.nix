{
  config,
  lib,
  pkgs,
  ...
}:
let
  options = {
    transparency = config.style.windowOpacity;
    cursor_animation_length = 8.0e-2;
    cursor_vfx_mode = "railgun";
    cursor_vfx_particle_density = 20;
    fork = true;
    font = {
      normal = [
        "monospace"
      ];
      inherit (config.gui.fonts.monospace) size;
    };
  };
  package = pkgs.neovide;
in
{
  options.guiEditorCommand = lib.mkOption {
    type = with lib.types; nullOr pathInStore;
    default = if config.gui.enable then lib.getExe package else null;
  };

  config = lib.mkIf config.gui.enable {
    home.packages = [ package ];
    xdg.configFile."neovide/config.toml".source = pkgs.writers.writeTOML "neovide/config.toml" options;
  };
}
