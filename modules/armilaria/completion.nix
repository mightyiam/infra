{
  armilaria = {
    plugins = {
      cmp = {
        enable = true;
        settings = {
          sources = [
            {
              name = "path";
              group_index = 2;
            }
            {
              name = "luasnip";
              group_index = 1;
            }
            {
              name = "nvim_lsp";
              group_index = 1;
            }
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };
      luasnip.enable = true;
      cmp_luasnip.enable = true;
    };
  };
}
