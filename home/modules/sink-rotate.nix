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

  keyboard = import ../keyboard.nix;
in
  mkIf config.gui.enable {
    wayland.windowManager.sway.config.keybindings."${keyboard.wm.volume.sinkRotate}" = "exec ${pkgs.sink-rotate}/bin/sink-rotate";
  }
