{lib, ...}: {
  home.gui = {
    options.gui.editor.command = lib.mkOption {
      type = lib.types.pathInStore;
    };
  };
}
