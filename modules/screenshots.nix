{ lib, ... }:
{
  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    let
      mkScript =
        target:
        pkgs.writeShellApplication {
          name = "take-screenshot-and-edit-it-${target}";
          runtimeInputs = [
            pkgs.grimblast
            hmArgs.config.programs.satty.package
          ];
          text = ''
            grimblast save ${target} - | satty --filename -
          '';
        };
    in
    {
      home.packages = [
        pkgs.grimblast
        hmArgs.config.programs.satty.package
      ];

      programs.satty = {
        enable = true;
        settings.general = {
          corner-roundness = 6;
          initial-tool = "brush";
          copy-command = lib.getExe' pkgs.wl-clipboard-rs "wl-copy";
          output-filename = "${hmArgs.config.xdg.userDirs.desktop}/screenshot-%Y-%m-%d_%H:%M:%S.png";
          actions-on-enter = [ "save-to-clipboard" ];
          actions-on-escape = [ "exit" ];
        };
      };

      wayland.windowManager.hyprland.settings.bind =
        [
          {
            key = "w";
            target = "active";
          }
          {
            key = "o";
            target = "output";
          }
          {
            key = "r";
            target = "area";
          }
        ]
        |> map (
          { key, target }:
          [
            "SUPER+SHIFT"
            key
            "exec"
            (mkScript target |> lib.getExe)
          ]
          |> lib.concatStringsSep ", "
        );
    };
}
