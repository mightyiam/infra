{
  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    let
      shotman = "${pkgs.shotman}/bin/shotman --capture";
    in
    {
      wayland.windowManager.sway.config.keybindings =
        let
          mod = hmArgs.config.wayland.windowManager.sway.config.modifier;
        in
        {
          "${mod}+Shift+w" = "exec ${shotman} window";
          "${mod}+Shift+o" = "exec ${shotman} output";
          "${mod}+Shift+r" = "exec ${shotman} region";
        };
    };
}
