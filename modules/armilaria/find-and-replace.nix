{lib, ...}: {
  armilaria = {pkgs, ...}: {
    plugins = {
      grug-far = {
        enable = true;
        settings = {
          engine = "ripgrep";
          engines.ripgrep.path = lib.getExe pkgs.ripgrep-all;
        };
      };

      spectre.enable = true;
    };

    keymaps = [
      # TODO
      # ["<leader>"] = {
      #   s = {
      #     s = {
      #       '<cmd>lua require("spectre").toggle()<CR>',
      #       "Toggle Spectre",
      #     },
      #     w = {
      #       '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
      #       "Search current word",
      #     },
      #     p = {
      #       '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
      #       "Search current file",
      #     },
      #   },
      # },
    ];
  };
}
