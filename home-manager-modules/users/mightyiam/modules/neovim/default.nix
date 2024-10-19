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
    ./luasnip.nix
    ./nvim-surround.nix
    ./rustaceanvim.nix
    ./telescope.nix
    ./treesitter.nix
    ./vimdiff.nix
    ./which-key.nix
    ./nvim-autopairs.nix
    ./fidget.nix
    self.inputs.nixvim.homeManagerModules.nixvim
  ];
}

# {
#   programs.neovim = {
#     plugins = [
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
#     ];
#   };
# }

# lsp_zero.setup_servers({
# 	"eslint",
# 	"lua_ls",
# 	"nixd",
# 	"ts_ls",
# 	"yamlls",
# })
# 

#         nnoremap ${config.keyboard.refactor.nixfmt} <cmd>!nix fmt %<cr>

# catppuccin
