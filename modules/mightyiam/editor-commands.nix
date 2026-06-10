{lib, ...}: {
  home.gui = hmArgs: {
    options.gui.editor.command = lib.mkOption {
      type = lib.types.pathInStore;
    };
    config.home.sessionVariables.VISUAL = hmArgs.config.gui.editor.command;
  };
}
