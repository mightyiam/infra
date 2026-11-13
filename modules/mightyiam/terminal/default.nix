{lib, ...}: {
  home.gui = hmArgs @ {pkgs, ...}: {
    options.terminal = {
      path = lib.mkOption {
        type = lib.types.path;
        default = null;
      };
      desktopFileId = lib.mkOption {
        type = lib.types.singleLineStr;
      };
    };
    config = {
      xdg.terminal-exec = {
        enable = true;
        settings.default = [hmArgs.config.terminal.desktopFileId];
      };
      wayland.windowManager = {
        hyprland.settings.bind = [
          {
            _args = [
              "SUPER + RETURN"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${hmArgs.config.terminal.path}")'')
            ];
          }
          {
            _args = [
              "SUPER + SHIFT + RETURN"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${hmArgs.config.terminal.path} --working-directory `${lib.getExe pkgs.hyprcwd}`")'')
            ];
          }
        ];
      };
    };
  };
}
