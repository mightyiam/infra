{
  pkgs,
  config,
  ...
}: let
  keyboard = import ../../keyboard.nix;
in {
  wayland.windowManager.sway.config.keybindings."${keyboard.wm.volume.sinkRotate}" = "exec ${pkgs.sink-rotate}/bin/sink-rotate";
}
