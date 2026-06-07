{
  lib,
  withSystem,
  ...
}: {
  perSystem = {pkgs, ...}: {
    # TODO overlay
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

  home.gui = hmArgs @ {pkgs, ...}: let
    hyprlandStateFile = "${hmArgs.config.xdg.stateHome}/hyprland-rotate-kb-layout";

    hyprland-rotate-keyboard-layout = pkgs.writeShellApplication {
      name = "hyprland-rotate-kb-layout";
      runtimeInputs = with pkgs; [hyprland];
      text = ''
        hyprctl switchxkblayout main next
        touch "${hyprlandStateFile}"
      '';
    };
  in {
    wayland.windowManager.hyprland.settings = {
      bind = [
        "ALT+SHIFT, SHIFT_L, exec, ${hyprland-rotate-keyboard-layout |> lib.getExe}"
      ];
      input.kb_layout = "us,il";
    };

    programs.i3status-rust.bars.bottom.blocks = lib.mkOrder 1200 [
      {
        block = "custom";
        watch_files = [hyprlandStateFile];
        interval = "once";
        command =
          withSystem pkgs.stdenv.hostPlatform.system (
            psArgs: psArgs.config.packages.get-hyprland-main-keyboard-layout
          )
          |> lib.getExe;
      }
    ];
  };
}
