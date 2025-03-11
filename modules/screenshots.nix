{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    let
      shotman = "${pkgs.shotman}/bin/shotman --capture";
    in
    {
      wayland.windowManager.sway.config.keybindings = {
        "Mod4+Shift+w" = "exec ${shotman} window";
        "Mod4+Shift+o" = "exec ${shotman} output";
        "Mod4+Shift+r" = "exec ${shotman} region";
      };
    };
}
