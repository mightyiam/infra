{lib, ...}: {
  armilaria = {
    globals = lib.genAttrs ["mapleader" "maplocalleader"] (_: ",");
  };
}
