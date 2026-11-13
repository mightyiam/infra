{lib, ...}: {
  home.gui = hmArgs: {
    programs.rofi = {
      enable = true;
      settings = {
        terminal = hmArgs.config.terminal.path;
        modes = ["run" "drun" "window"];
        show-icons = true;
        drun-display-format = "{icon} {name}";
        display-drun = "   Apps ";
        display-run = "   Run ";
        display-window = " 󰕰  Window";
        display-Network = " 󰤨  Network";
      };
      theme = {
        listview.columns = 1;
        "*".width = 1200;
      };
    };

    wayland.windowManager = let
      rofi = lib.getExe hmArgs.config.programs.rofi.package;
    in {
      hyprland.settings.bind = [
        {
          _args = [
            "SUPER + d"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${rofi} -show drun")'')
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + d"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${rofi} -show run")'')
          ];
        }
      ];
    };
  };
}
