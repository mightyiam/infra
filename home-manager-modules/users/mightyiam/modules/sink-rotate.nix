{
  self,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkIf
    ;

  sink-rotate = self.inputs.sink-rotate.packages.${pkgs.system}.default;
in
  mkIf config.gui.enable {
    wayland.windowManager.sway.config.keybindings."${config.keyboard.wm.volume.sinkRotate}" = "exec ${sink-rotate}/bin/sink-rotate";
    home.packages = [sink-rotate];
  }
