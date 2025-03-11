{ lib, ... }:
{
  flake.modules.homeManager.base =
    {
      pkgs,
      config,
      ...
    }:
    let
      shotman = "${pkgs.shotman}/bin/shotman --capture";
    in
    lib.mkIf config.gui.enable {
      wayland.windowManager.sway.config.keybindings."Mod4+Shift+w" = "exec ${shotman} window";
      wayland.windowManager.sway.config.keybindings."Mod4+Shift+o" = "exec ${shotman} output";
      wayland.windowManager.sway.config.keybindings."Mod4+Shift+r" = "exec ${shotman} region";
    };
}
