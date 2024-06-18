{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (pkgs.writers) writeTOML;

  options = {
    transparency = config.style.windowOpacity;
    cursor_animation_length = 0.08;
    cursor_vfx_mode = "railgun";
    cursor_vfx_particle_density = 20;
    fork = true;
  };
in
  mkIf config.gui.enable {
    home.packages = [pkgs.neovide];
    xdg.configFile."neovide/config.toml".source = writeTOML "neovide/config.toml" options;
  }
