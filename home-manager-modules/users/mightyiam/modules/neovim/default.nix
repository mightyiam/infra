{ self, ... }:
{
  programs.nixvim.enable = true;
  imports = [
    ./autoread.nix
    ./default-editor.nix
    ./leader.nix
    ./lsp
    ./rustaceanvim.nix
    ./vimdiff.nix
    ./which-key.nix
    self.inputs.nixvim.homeManagerModules.nixvim
  ];
}

# {
#   programs.neovim = {
#     plugins = [
#       (omitPluginInVSCode pkgs.vimPlugins.which-key-nvim (embedLua ''
#         require("which-key").setup {}
#       ''))
#       (omitPluginInVSCode pkgs.vimPlugins.vim-nix "")
#       {
#         plugin = pkgs.vimPlugins.vim-easymotion;
#         config = ''
#           map ${config.keyboard.easyMotion} <Plug>(easymotion-prefix)
#         '';
#       }
#       (omitPluginInVSCode pkgs.vimPlugins.ctrlp-vim ''
#         let g:ctrlp_user_command = ['.git', 'cd %s && ${pkgs.git}/bin/git ls-files -co --exclude-standard']
#       '')
#       # (omitPluginInVSCode vimPlugins.nvim-treesitter.withAllGrammars (embedLua ''
#       #   require'nvim-treesitter.configs'.setup {
#       #     auto_install = false,
#       #     highlight = {
#       #       enable = true,
#       #     }
#       #   }
#       # ''))
#       {
#         plugin = pkgs.vimPlugins.nvim-surround;
#         config = embedLua ''
#           require('nvim-surround').setup()
#         '';
#       }
#       {
#         plugin = pkgs.vimPlugins.comment-nvim;
#         config = embedLua ''
#           require('Comment').setup({
#             mappings = { basic = false, extra = false },
#           })
# 
#           require("which-key").add({
#             { "<leader>c", group = "comment" },
#             { "<leader>cl", "<Plug>(comment_toggle_linewise)", desc = "toggle line linewise" },
#             { "<leader>cb", "<Plug>(comment_toggle_blockwise)", desc = "toggle line blockwise" },
#             {
#               mode = "v",
#               { "<leader>cl", "<Plug>(comment_toggle_linewise_visual)", desc = "toggle line linewise" },
#               { "<leader>cb", "<Plug>(comment_toggle_blockwise_visual)", desc = "toggle line blockwise" },
#             }
#           })
#         '';
#       }
#       {
#         plugin = pkgs.vimPlugins.guess-indent-nvim;
#         config = embedLua ''
#           require('guess-indent').setup {}
#         '';
#       }
#       (omitPluginInVSCode pkgs.vimPlugins.lualine-nvim (embedLua ''
#         local winbar = {
#           lualine_a = {
#             'encoding',
#             'fileformat',
#           },
#           lualine_b = {
#             'filetype',
#           },
#           lualine_c = {
#             {
#               'filename',
#               path = 1,
#               shorting_target = 0,
#             },
#           },
#           lualine_x = {
#             'diff',
#           },
#           lualine_y = {
#             '%o',
#             'location',
#           },
#           lualine_z = {
#             'progress',
#           }
#         }
# 
#         require('lualine').setup({
#           options = {
#             globalstatus = true,
#             section_separators = "",
#             component_separators = "",
# 
#             disabled_filetypes = {
#               winbar = {
#                 'Trouble',
#               },
#             },
# 
#             ignore_focus = {
#                 'Trouble',
#             },
#           },
# 
#           extensions = {
#             'trouble',
#           },
# 
#           winbar = winbar,
#           inactive_winbar = winbar,
# 
#           sections = {
#             lualine_a = {
#               'mode',
#             },
#             lualine_b = {
#               {
#                 'diagnostics',
#                 sources = { 'nvim_lsp' },
#               },
#             },
#             lualine_c = {
#             },
#             lualine_x = {
#             },
#             lualine_y = {
#             },
#             lualine_z = {
#               'branch',
#             },
#           },
#         })
#       ''))
#       (omitPluginInVSCode pkgs.vimPlugins.vim-gitgutter "")
#       (omitPluginInVSCode pkgs.vimPlugins.nvim-lspconfig "")
#       (omitPluginInVSCode pkgs.vimPlugins.rustaceanvim (embedLua ''
#         vim.g.rustaceanvim = {
#           tools = {
#           },
#           server = {
#             on_attach = function(client, bufnr)
#               require("which-key").add({
#                 { "<space>", group = "Rust" },
#                 { "<space>a", function() vim.cmd.RustLsp('codeAction') end, desc = "code action" },
#                 { "<space>p", "<CMD>RustLsp parentModule<CR>", desc = "go to parent module" },
#               })
#             end,
#             settings = {
#               ['rust-analyzer'] = {
#                 checkOnSave = {
#                   command = "clippy"
#                 },
#                 inlayHints = {
#                   maxLength = 99,
#                 },
#                 cargo = {
#                   features = "all",
#                 },
#               },
#             },
#           },
#           dap = {
#           },
#         }
#       ''))
#       (omitPluginInVSCode pkgs.vimPlugins.cmp-nvim-lsp "")
#       (omitPluginInVSCode pkgs.vimPlugins.nvim-cmp "")
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
#       (omitPluginInVSCode pkgs.vimPlugins.telescope-nvim (embedLua ''
#         local telescope = require("telescope")
#         local telescopeConfig = require("telescope.config")
#         local builtin = require('telescope.builtin')
# 
#         local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
# 
#         -- I want to search in hidden/dot files.
#         table.insert(vimgrep_arguments, "--hidden")
#         -- I don't want to search in the `.git` directory.
#         table.insert(vimgrep_arguments, "--glob")
#         table.insert(vimgrep_arguments, "!**/.git/*")
# 
#         telescope.setup({
#           defaults = {
#             -- `hidden = true` is not supported in text grep commands.
#             vimgrep_arguments = vimgrep_arguments,
#           },
#            pickers = {
#              find_files = {
#                -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
#                find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
#              },
#            },
#         })
# 
#         vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
#         vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
#         vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
#         vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
#         vim.keymap.set('n', '<leader>fc', builtin.commands, {})
#         vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
#         vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
#         vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
#         vim.keymap.set('n', '<leader>fds', builtin.lsp_document_symbols, {})
#         vim.keymap.set('n', '<leader>fs', builtin.lsp_workspace_symbols, {})
#         vim.keymap.set('n', '<leader>fp', builtin.diagnostics, {})
#         vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, {})
#         vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, {})
#         vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, {})
#         vim.keymap.set('n', '<leader>fa', builtin.builtin, {})
#         vim.keymap.set('n', '<leader>f;', builtin.resume, {})
#       ''))
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
