{inputs, ...}: {
  flake-file.inputs.treesitter-modules-nvim = {
    flake = false;
    url = "github:MeanderingProgrammer/treesitter-modules.nvim";
  };

  armilaria = nixvimArgs @ {pkgs, ...}: {
    extraPlugins = [
      # TODO upstream OR treesitter-textobjects
      (pkgs.vimUtils.buildVimPlugin {
        pname = "treesitter-modules.nvim";
        version = "unstable";
        src = inputs.treesitter-modules-nvim;
        dependencies = [pkgs.vimPlugins.nvim-treesitter];
      })
    ];

    extraConfigLuaPost = ''
      require("treesitter-modules").setup ${
        nixvimArgs.lib.nixvim.lua.toLuaObject {
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<CR>";
              node_incremental = "<CR>";
              node_decremental = "<BS>";
            };
          };
        }
      }
    '';
  };
}
