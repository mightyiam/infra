{ self, ... }:
{
  programs.nixvim.enable = true;
  imports = [
    ./autoread.nix
    ./clipboard.nix
    ./cmp
    ./comment.nix
    ./default-editor.nix
    ./flash.nix
    ./gitgutter.nix
    ./guess-indent.nix
    ./leader.nix
    ./lsp
    ./lualine.nix
    ./nvim-surround.nix
    ./rustaceanvim.nix
    ./telescope.nix
    ./treesitter.nix
    ./vimdiff.nix
    ./which-key.nix
    self.inputs.nixvim.homeManagerModules.nixvim
  ];
}

# {
#   programs.neovim = {
#     plugins = [
#       (omitPluginInVSCode pkgs.vimPlugins.luasnip "")
#       (omitPluginInVSCode pkgs.vimPlugins.nvim-autopairs (embedLua ''
#         require("nvim-autopairs").setup{}
#       ''))
#       (omitPluginInVSCode lsp-zero ''
#       '')
#       (omitPluginInVSCode pkgs.vimPlugins.fidget-nvim (inlineLuaFile ./lua/lsp/fidget-nvim.lua))
#       (omitPluginInVSCode pkgs.vimPlugins.symbols-outline-nvim "")
#       pkgs.vimPlugins.plenary-nvim
#       (omitPluginInVSCode pkgs.vimPlugins.null-ls-nvim (inlineLuaFile ./lua/lsp/null-ls.lua))
#       (omitPluginInVSCode pkgs.vimPlugins.nvim-web-devicons "") # for trouble-nvim
#       (omitPluginInVSCode pkgs.vimPlugins.trouble-nvim (embedLua ''
#         require("trouble").setup {}
#         require("which-key").add({
#           { "<leader>x", group = "trouble" },
#           { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>" },
#           { "<leader>xl", "<cmd>Trouble lsp toggle<cr>" },
#           { "<leader>xD", "<cmd>Trouble lsp_declarations toggle<cr>" },
#           { "<leader>xd", "<cmd>Trouble lsp_definitions toggle<cr>" },
#           { "<leader>xi", "<cmd>Trouble lsp_implementations toggle<cr>" },
#           { "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>" },
#           { "<leader>xt", "<cmd>Trouble lsp_type_definitions toggle<cr>" },
#           { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>" },
#         })
#       ''))
#       (omitPluginInVSCode pkgs.vimPlugins.unicode-vim "")
#       # (omitPluginInVSCode vimPlugins.nvim-spectre (embedLua ''
#       #   require('spectre').setup()
#       #   local wk = require('which-key')
#       #
#       #   wk.register({
#       #     ["<leader>"] = {
#       #       s = {
#       #         s = {
#       #           '<cmd>lua require("spectre").toggle()<CR>',
#       #           "Toggle Spectre",
#       #         },
#       #         w = {
#       #           '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
#       #           "Search current word",
#       #         },
#       #         p = {
#       #           '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
#       #           "Search current file",
#       #         },
#       #       },
#       #     },
#       #   })
#       # ''))
#     ];
#     extraConfig = lib.concatStringsSep "\n" [
#       ''
#         set ignorecase
#         vnoremap ${config.keyboard.text.dedent} <gv
#         vnoremap ${config.keyboard.text.indent} >gv
#         set updatetime=100
#         set scrolloff=0
#         let g:loaded_perl_provider = 0
# 
#         set title
#         set titlestring=\ %{substitute(getcwd(),\ $HOME,\ '~',\ '''''')}
#       ''
#       (omitVIMLInVSCode ''
#         set number
#         set guifont=monospace:h${builtins.floor config.gui.fonts.monospace.size |> toString}
#       '')
#       (omitVIMLInVSCode "lua require('lsp.index')\n")
#     ];
#   };
#   xdg.configFile."nvim/lua" = {
#     recursive = true;
#     source = ./lua;
#   };
#   xdg.configFile."nvim/lua/luafun" = {
#     recursive = true;
#     source = luafun;
#   };
# }

# require("fidget").setup({})

# require("luafun.fun")()
# local lsp_zero = require("lsp-zero")
# lsp_zero.preset("system-lsp")
# lsp_zero.setup_servers({
# 	"eslint",
# 	"lua_ls",
# 	"nixd",
# 	"ts_ls",
# 	"yamlls",
# })
# lsp_zero.set_preferences({
# 	set_lsp_keymaps = false,
# })
# 
# require("lsp.lua")(lsp_zero)
# 
# lsp_zero.setup()

#         nnoremap ${config.keyboard.refactor.nixfmt} <cmd>!nix fmt %<cr>

# catppuccin
