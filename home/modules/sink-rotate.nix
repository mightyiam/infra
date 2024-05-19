{
  pkgs,
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
    wayland.windowManager.sway.config.keybindings."${config.keyboard.wm.volume.sinkRotate}" = "exec ${pkgs.sink-rotate}/bin/sink-rotate";
  }
