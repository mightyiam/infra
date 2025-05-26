{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    {
      home.packages = [
        pkgs.shotman
        pkgs.grimblast
      ];

      wayland.windowManager = {
        sway.config.keybindings =
          let
            mod = hmArgs.config.wayland.windowManager.sway.config.modifier;
          in
          {
            "${mod}+Shift+w" = "exec ${lib.getExe' pkgs.shotman "shotman"} --capture window";
            "${mod}+Shift+o" = "exec ${lib.getExe' pkgs.shotman "shotman"} --capture output";
            "${mod}+Shift+r" = "exec ${lib.getExe' pkgs.shotman "shotman"} --capture region";
          };

        hyprland.settings.bind = [
          "SUPER+SHIFT, w, exec, ${lib.getExe pkgs.grimblast} copy active"
          "SUPER+SHIFT, o, exec, ${lib.getExe pkgs.grimblast} copy output"
          "SUPER+SHIFT, r, exec, ${lib.getExe pkgs.grimblast} copy area"
        ];
      };
    };
}
