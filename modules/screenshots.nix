{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    let
      shotman = "${lib.getExe' pkgs.shotman "shotman"} --capture";
    in
    {
      home.packages = [ pkgs.shotman ];

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
