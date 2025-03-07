{
  flake.modules.nixvim.astrea.keymaps =
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
