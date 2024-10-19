{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      settings = {
        sources = [
          {
            name = "path";
            group_index = 2;
          }
        ];
      };
    };
  };
}
