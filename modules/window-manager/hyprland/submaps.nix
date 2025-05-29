{ lib, ... }:
{
  flake.modules.homeManager.gui = {
    options.wayland.windowManager.hyprland.submapEnd = lib.mkOption {
      type = lib.types.lines;
      default = ''
        bind = , escape, submap, reset
        bind = , catchall, exec, true
        submap = reset
      '';
    };
  };
}
