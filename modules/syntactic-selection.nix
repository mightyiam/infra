{ inputs, ... }:
{
  flake.modules.nixvim.base =
    nixvimArgs@{ pkgs, ... }:
    {
      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "treesitter-modules.nvim";
          src = inputs.treesitter-modules-nvim;
          dependencies = [ pkgs.vimPlugins.nvim-treesitter ];
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
