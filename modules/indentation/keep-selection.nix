{
  flake.modules.nixvim.base.keymaps =
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
}
