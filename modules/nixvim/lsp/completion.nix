{
  flake.modules.nixvim.base.plugins.cmp.settings.sources = [
    {
      name = "nvim_lsp";
      group_index = 1;
    }
  ];
}
