{ lib, withSystem, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.hyprcwd = pkgs.writeShellApplication {
        name = "hyprcwd";
        runtimeInputs = with pkgs; [
          coreutils
          hyprland
          jq
          procps
        ];
        # https://github.com/vilari-mickopf/hyprcwd
        text = ''
          pid=$(hyprctl activewindow -j | jq '.pid')
          ppid=$(pgrep --newest --parent "$pid")
          dir=$(readlink /proc/"$ppid"/cwd || echo "$HOME")
          [ -d "$dir" ] && echo "$dir" || echo "$HOME"
        '';
      };
    };

  flake.modules.homeManager = {
    base =
      { pkgs, ... }:
      {
        options.terminal = {
          path = lib.mkOption {
            type = lib.types.path;
            default = null;
          };
          withTitle = lib.mkOption {
            type = lib.types.functionTo lib.types.str;
            default = null;
          };
        };

        config.home.packages = with pkgs; [ ansifilter ];
      };
    gui =
      hmArgs@{ pkgs, ... }:
      let
        hyprcwd = withSystem pkgs.system (psArgs: psArgs.config.packages.hyprcwd);
      in
      {
        terminal = {
          path = lib.getExe hmArgs.config.programs.alacritty.package;
          withTitle = cmd: "${hmArgs.config.terminal.path} --title ${cmd} --command ${cmd}";
        };

        programs.alacritty = {
          enable = true;
          settings = {
            general.live_config_reload = true;
            window = {
              decorations = "none";
              dynamic_title = true;
              title = "Terminal";
            };
            bell = {
              # https://github.com/danth/stylix/discussions/1207
              # ideally this would be some stylix color theme color
              color = "#000000";
              duration = 200;
            };
          };
        };

        home.packages = [
          pkgs.swaycwd
          hyprcwd
        ];

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
                "--no-repeat ${mod}+Return" = "exec ${lib.getExe hmArgs.config.programs.alacritty.package}";
                "--no-repeat ${mod}+Shift+Return" =
                  "exec ${lib.getExe hmArgs.config.programs.alacritty.package} --working-directory `${lib.getExe pkgs.swaycwd}`";
              };
          };
        };
      };
  };
}
