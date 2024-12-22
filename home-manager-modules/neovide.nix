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
in
lib.mkIf config.gui.enable {
  home.packages = [ pkgs.neovide ];
  xdg.configFile."neovide/config.toml".source = pkgs.writers.writeTOML "neovide/config.toml" options;
}
