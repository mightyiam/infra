{
  flake.modules.nixvim.base.plugins = {
    cmp = {
      enable = true;
      settings = {
        sources = [
          {
            name = "path";
            group_index = 2;
          }
        ];
        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
      };
    };
  };
}
