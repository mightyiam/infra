{
  flake.modules.nixvim.astrea.plugins = {
    luasnip.enable = true;
    cmp_luasnip.enable = true;
    cmp.settings.sources = [
      {
        name = "luasnip";
        group_index = 1;
      }
    ];
  };
}
