{
  flake.modules.nixvim.astrea = {
    plugins.treesitter-context.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>c";
        action = "<CMD>TSContextToggle<CR>";
      }
    ];
  };
}
