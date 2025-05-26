{ lib, withSystem, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.get-hyprland-main-keyboard-layout = pkgs.writeShellApplication {
        name = "get-hyprland-main-keyboard-layout";
        runtimeInputs = with pkgs; [
          hyprland
          jq
        ];
        text = ''
          hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap | select(. == "English (US)" or . == "Hebrew") | if . == "English (US)" then "us" else "il" end'
        '';
      };
    };

  flake.modules.homeManager.gui =
    hmArgs@{ pkgs, ... }:
    let
      layout =
        [
          "us"
          "il"
        ]
        |> lib.concatStringsSep ",";

      hyprlandStateFile = "${hmArgs.config.xdg.stateHome}/hyprland-rotate-kb-layout";

      hyprland-rotate-keyboard-layout = pkgs.writeShellApplication {
        name = "hyprland-rotate-kb-layout";
        runtimeInputs = with pkgs; [ hyprland ];
        text = ''
          hyprctl switchxkblayout main next 
          touch "${hyprlandStateFile}"
        '';
      };
    in
    {
      wayland.windowManager = {
        sway.config.input."type:keyboard" = {
          xkb_layout = layout;
          xkb_options = "grp:lalt_lshift_toggle";
        };

        hyprland.settings = {
          bind = [
            "ALT+SHIFT, SHIFT_L, exec, ${hyprland-rotate-keyboard-layout |> lib.getExe}"
          ];
          input.kb_layout = layout;
        };
      };

      programs.i3status-rust.bars.bottom.blocks = lib.mkOrder 1200 [
        {
          block = "keyboard_layout";
          if_command = pkgs.writeShellScript "in-sway" ''
            [ "$XDG_CURRENT_DESKTOP" = "sway" ]
          '';
          driver = "sway";
          mappings = {
            "English (US)" = "EN";
            "Hebrew (N/A)" = "HE";
          };
        }
        {
          block = "custom";
          if_command = pkgs.writeShellScript "in-hyprland" ''
            [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]
          '';
          watch_files = [ hyprlandStateFile ];
          interval = "once";
          command =
            withSystem pkgs.system (psArgs: psArgs.config.packages.get-hyprland-main-keyboard-layout)
            |> lib.getExe;
        }
      ];
    };
}
