{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    {
      home.packages = [ pkgs.shotman ];

      wayland.windowManager.sway.config.keybindings =
        let
          mod = hmArgs.config.wayland.windowManager.sway.config.modifier;
        in
        {
          "${mod}+Shift+w" = "exec ${lib.getExe' pkgs.shotman "shotman"} --capture window";
          "${mod}+Shift+o" = "exec ${lib.getExe' pkgs.shotman "shotman"} --capture output";
          "${mod}+Shift+r" = "exec ${lib.getExe' pkgs.shotman "shotman"} --capture region";
        };
    };
}
