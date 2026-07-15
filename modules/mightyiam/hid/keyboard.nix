{lib, ...}: {
  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        get-hyprland-main-keyboard-layout = prev.callPackage ./get-hyprland-main-keyboard-layout.pkg.nix {};
      })
    ];
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
