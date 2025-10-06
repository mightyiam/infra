{
  flake.modules.nixvim.base = {
    plugins.treesitter-context.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>c";
        action = "<CMD>TSContext toggle<CR>";
      }
    ];
  };
}
