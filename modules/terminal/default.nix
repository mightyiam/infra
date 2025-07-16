{ lib, withSystem, ... }:
{
  flake.modules.homeManager = {
    base = {
      options.terminal = {
        path = lib.mkOption {
          type = lib.types.path;
          default = null;
        };
      };

    };
    gui =
      hmArgs@{ pkgs, ... }:
      let
        hyprcwd = withSystem pkgs.system (psArgs: psArgs.config.packages.hyprcwd);
      in
      {
        wayland.windowManager = {
          hyprland.settings.bind = [
            "SUPER, Return, exec, ${hmArgs.config.terminal.path}"
            "SUPER+SHIFT, Return, exec, ${hmArgs.config.terminal.path} --working-directory `${lib.getExe hyprcwd}`"
          ];

          sway.config = {
            terminal = hmArgs.config.terminal.path;
            keybindings =
              let
                mod = hmArgs.config.wayland.windowManager.sway.config.modifier;
              in
              {
                "${mod}+Return" = null;
                "--no-repeat ${mod}+Return" = "exec ${hmArgs.config.terminal.path}";
                "--no-repeat ${mod}+Shift+Return" =
                  "exec ${hmArgs.config.terminal.path} --working-directory `${lib.getExe pkgs.swaycwd}`";
              };
          };
        };
      };
  };
}
