{
  armilaria = {
    opts = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };
    plugins = {
      guess-indent.enable = true;
      treesitter.indent.enable = true;
    };
    keymaps =
      map
      (key: {
        inherit key;
        action = "${key}gv";
        mode = "v";
      })
      [
        "<"
        ">"
      ];
  };
}
