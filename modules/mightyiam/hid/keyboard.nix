{lib, ...}: let
  get-hyprland-main-keyboard-layout = {
    writeShellApplication,
    hyprland,
    jq,
  }:
    writeShellApplication {
      name = "get-hyprland-main-keyboard-layout";
      runtimeInputs = [
        hyprland
        jq
      ];
      text = ''
        hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap | select(. == "English (US)" or . == "Hebrew") | if . == "English (US)" then "us" else "il" end'
      '';
    };
in {
  nixpkgs.overlays = [
    (final: prev: {
      get-hyprland-main-keyboard-layout = prev.callPackage get-hyprland-main-keyboard-layout {};
    })
  ];

  perSystem = {pkgs, ...}: {
    packages = {inherit (pkgs) get-hyprland-main-keyboard-layout;};
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
        command = lib.getExe pkgs.get-hyprland-main-keyboard-layout;
      }
    ];
  };
}
