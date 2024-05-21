{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit
    (builtins)
    floor
    ;

  inherit
    (lib)
    concatStringsSep
    mkBefore
    pipe
    readFile
    ;

  inherit
    (pkgs)
    vimPlugins
    ;

  inherit (config) keyboard;
  omitVIMLInVSCode = import ./omitVIMLInVSCode.nix;
  omitPluginInVSCode = import ./omitPluginInVSCode.nix;
  inlineLuaFile = path:
    concatStringsSep "" [
      "lua << EOF\n"
      (readFile path)
      "EOF\n"
    ];
  lsp-zero = pkgs.vimUtils.buildVimPlugin rec {
    pname = "lsp-zero";
    version = "072e486271c7068b6732924d47ea0ac9ec55423b";
    src = pkgs.fetchFromGitHub {
      owner = "VonHeikemen";
      repo = "lsp-zero.nvim";
      rev = version;
      sha256 = "8zQoSYdh6Xf+guxxMdXtiVmJB+brNTEJWdrGefL0QwY=";
    };
  };
  vim-autoread = pkgs.vimUtils.buildVimPlugin rec {
    pname = "vim-autoread";
    version = "24061f84652d768bfb85d222c88580b3af138dab";
    src = pkgs.fetchFromGitHub {
      owner = "djoshea";
      repo = "vim-autoread";
      rev = version;
      sha256 = "fSADjNt1V9jgAPjxggbh7Nogcxyisi18KaVve8j+c3w=";
    };
  };
  luafun = pkgs.fetchFromGitHub {
    owner = "luafun";
    repo = "luafun";
    rev = "0.1.3";
    sha256 = "aOriC7VD29XzchvLOfmySNDR1MtO1xrqHYABRMaDoJo=";
  };

  lsp-inlayhints-nvim = pkgs.vimUtils.buildVimPlugin rec {
    pname = "lsp-inlayhints.nvim";
    version = "d981f65c9ae0b6062176f0accb9c151daeda6f16";
    src = pkgs.fetchFromGitHub {
      owner = "lvimuser";
      repo = "lsp-inlayhints.nvim";
      rev = version;
      sha256 = "sha256-06CiJ+xeMO4+OJkckcslqwloJyt2gwg514JuxV6KOfQ=";
    };
    meta.homepage = "https://github.com/lvimuser/lsp-inlayhints.nvim/";
  };

  embedLua = lua: ''
    lua << EOF
    ${lua}EOF
  '';
in {
  xdg.configFile."nvim/init.lua".text =
    mkBefore ''
      vim.cmd [[let mapleader = "${keyboard.leader}"]]'';
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = [
      (omitPluginInVSCode vimPlugins.which-key-nvim (embedLua ''
        require("which-key").setup {}
      ''))
      (omitPluginInVSCode vimPlugins.vim-nix "")
      {
        plugin = vimPlugins.vim-easymotion;
        config = ''
          map ${keyboard.easyMotion} <Plug>(easymotion-prefix)
        '';
      }
      (omitPluginInVSCode vimPlugins.ctrlp-vim ''
        let g:ctrlp_user_command = ['.git', 'cd %s && ${pkgs.git}/bin/git ls-files -co --exclude-standard']
      '')
      (omitPluginInVSCode vimPlugins.nvim-treesitter.withAllGrammars (embedLua ''
        require'nvim-treesitter.configs'.setup {
          auto_install = false,
          highlight = {
            enable = true,
          }
        }
      ''))
      {
        plugin = vimPlugins.nvim-surround;
        config = embedLua ''
          require('nvim-surround').setup()
        '';
      }
      {
        plugin = vimPlugins.comment-nvim;
        config = embedLua ''
          require('Comment').setup({
            mappings = { basic = false, extra = false },
          })

          require("which-key").register({
            ["<leader>c" ] = {
              name = "comment",
              l = {
                "<Plug>(comment_toggle_linewise)",
                "toggle line linewise",
              },
              b = {
                "<Plug>(comment_toggle_blockwise)",
                "toggle line blockwise",
              },
            },
          })

          require("which-key").register({
            ["<leader>c"] = {
              name = "comment",
              l = {
                "<Plug>(comment_toggle_linewise_visual)",
                "toggle region linewise"
              },
              b = {
                "<Plug>(comment_toggle_blockwise_visual)",
                "toggle region blockwise"
              },
            },
          }, { mode = "v" })
        '';
      }
      {
        plugin = vimPlugins.guess-indent-nvim;
        config = embedLua ''
          require('guess-indent').setup {}
        '';
      }
      (omitPluginInVSCode vimPlugins.lualine-nvim (embedLua ''
        local winbar = {
          lualine_a = {
            'encoding',
            'fileformat',
          },
          lualine_b = {
            'filetype',
          },
          lualine_c = {
            {
              'filename',
              path = 1,
              shorting_target = 0,
            },
          },
          lualine_x = {
            'diff',
          },
          lualine_y = {
            '%o',
            'location',
          },
          lualine_z = {
            'progress',
          }
        }

        require('lualine').setup({
          options = {
            globalstatus = true,
            section_separators = "",
            component_separators = "",

            disabled_filetypes = {
              winbar = {
                'nerdtree',
                'Trouble',
              },
            },

            ignore_focus = {
                'nerdtree',
                'Trouble',
            },
          },

          extensions = {
            'nerdtree',
            'trouble',
          },

          winbar = winbar,
          inactive_winbar = winbar,

          sections = {
            lualine_a = {
              'mode',
            },
            lualine_b = {
              {
                'diagnostics',
                sources = { 'nvim_lsp' },
              },
            },
            lualine_c = {
            },
            lualine_x = {
            },
            lualine_y = {
            },
            lualine_z = {
              'branch',
            },
          },
        })
      ''))
      (omitPluginInVSCode vimPlugins.nerdtree ''
        nnoremap ${keyboard.fileTreeFocus} :NERDTreeFocus<CR>
        nnoremap ${keyboard.fileTreeToggle} :NERDTreeToggle<CR>
      '')
      (omitPluginInVSCode vimPlugins.nerdtree-git-plugin ''
        let g:NERDTreeGitStatusUseNerdFonts = 1
      '')
      (omitPluginInVSCode vimPlugins.vim-gitgutter "")
      (omitPluginInVSCode vimPlugins.nvim-lspconfig "")
      (omitPluginInVSCode vimPlugins.rustaceanvim (embedLua ''
        vim.g.rustaceanvim = {
          tools = {
          },
          server = {
            on_attach = function(client, bufnr)
              require("lsp-inlayhints").on_attach(client, bufnr)
              require("which-key").register({
                ["<space>"] = {
                  a = {
                    function()
                      vim.cmd.RustLsp('codeAction')
                    end,
                    "code action"
                  },
                  p = {
                    "<CMD>RustLsp parentModule<CR>",
                    "go to parent module",
                  },
                },
              })
            end,
            settings = {
              ['rust-analyzer'] = {
                checkOnSave = {
                  command = "clippy"
                },
                inlayHints = {
                  maxLength = 99,
                },
                cargo = {
                  features = "all",
                },
              },
            },
          },
          dap = {
          },
        }
      ''))
      (omitPluginInVSCode lsp-inlayhints-nvim (embedLua ''
        require("lsp-inlayhints").setup()

        require("which-key").register({
          ["<leader>"] = {
            h = {
              name = "inlay hints",
              t = {
                function()
                  require('lsp-inlayhints').toggle()
                end,
                "toggle"
              },
              r = {
                function()
                  require('lsp-inlayhints').reset()
                end,
                "reset",
              },
            }
          },
        })
      ''))
      (omitPluginInVSCode vimPlugins.cmp-nvim-lsp "")
      (omitPluginInVSCode vimPlugins.nvim-cmp "")
      (omitPluginInVSCode vimPlugins.luasnip "")
      (omitPluginInVSCode vimPlugins.nvim-autopairs (embedLua ''
        require("nvim-autopairs").setup{}
      ''))
      (omitPluginInVSCode lsp-zero ''
        nnoremap ${keyboard.show.type} <cmd>lua vim.lsp.buf.hover()<CR>
        nnoremap ${keyboard.show.signature} <cmd>lua vim.lsp.buf.signature_help()<CR>
        nnoremap ${keyboard.goTo.definition} <cmd>lua vim.lsp.buf.definition()<CR>
        nnoremap ${keyboard.goTo.declaration} <cmd>lua vim.lsp.buf.declaration()<CR>
        nnoremap ${keyboard.goTo.implementation} <cmd>lua vim.lsp.buf.implementation()<CR>
        nnoremap ${keyboard.goTo.type} <cmd>lua vim.lsp.buf.type_definition()<CR>
        nnoremap ${keyboard.goTo.diagnostics} <cmd>lua vim.diagnostic.setloclist()<CR>
        nnoremap ${keyboard.refactor.rename} <cmd>lua vim.lsp.buf.rename()<CR>
        nnoremap ${keyboard.refactor.actions} <cmd>lua vim.lsp.buf.code_action()<CR>
        xnoremap ${keyboard.refactor.actions} <cmd>lua vim.lsp.buf.code_action()<CR>
        nnoremap ${keyboard.refactor.format} <cmd>lua vim.lsp.buf.format({ async = false })<CR>
        nnoremap ${keyboard.diagnostic.next} <cmd>lua vim.diagnostic.goto_next()<CR>
        nnoremap ${keyboard.diagnostic.prev} <cmd>lua vim.diagnostic.goto_prev()<CR>
      '')
      (omitPluginInVSCode vimPlugins.fidget-nvim (inlineLuaFile ./lua/lsp/fidget-nvim.lua))
      (omitPluginInVSCode vimPlugins.symbols-outline-nvim "")
      vimPlugins.plenary-nvim
      (omitPluginInVSCode vimPlugins.null-ls-nvim (inlineLuaFile ./lua/lsp/null-ls.lua))
      (omitPluginInVSCode vimPlugins.telescope-nvim (embedLua ''
        local telescope = require("telescope")
        local telescopeConfig = require("telescope.config")
        local builtin = require('telescope.builtin')

        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        telescope.setup({
          defaults = {
            -- `hidden = true` is not supported in text grep commands.
            vimgrep_arguments = vimgrep_arguments,
          },
           pickers = {
             find_files = {
               -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
               find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
             },
           },
        })

        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fc', builtin.commands, {})
        vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
        vim.keymap.set('n', '<leader>fds', builtin.lsp_document_symbols, {})
        vim.keymap.set('n', '<leader>fs', builtin.lsp_workspace_symbols, {})
        vim.keymap.set('n', '<leader>fp', builtin.diagnostics, {})
        vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, {})
        vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, {})
        vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, {})
        vim.keymap.set('n', '<leader>fa', builtin.builtin, {})
      ''))
      (omitPluginInVSCode vimPlugins.nvim-web-devicons "") # for trouble-nvim
      (omitPluginInVSCode vimPlugins.trouble-nvim ''
        lua << EOF
          require("trouble").setup {}
        EOF
        nnoremap ${keyboard.diagnostic.toggle} <cmd>TroubleToggle<cr>
        nnoremap ${keyboard.diagnostic.workspace} <cmd>TroubleToggle workspace_diagnostics<cr>
        nnoremap ${keyboard.diagnostic.document} <cmd>TroubleToggle document_diagnostics<cr>
        nnoremap ${keyboard.diagnostic.quickfix} <cmd>TroubleToggle quickfix<cr>
        nnoremap ${keyboard.diagnostic.loclist} <cmd>TroubleToggle loclist<cr>
        nnoremap ${keyboard.goTo.references} <cmd>TroubleToggle lsp_references<cr>
      '')
      (omitPluginInVSCode vim-autoread ''
        autocmd VimEnter * nested WatchForChangesAllFile!
      '')
      (omitPluginInVSCode vimPlugins.unicode-vim "")
      (omitPluginInVSCode vimPlugins.nvim-spectre (embedLua ''
        require('spectre').setup()
        local wk = require('which-key')

        wk.register({
          ["<leader>"] = {
            s = {
              s = {
                '<cmd>lua require("spectre").toggle()<CR>',
                "Toggle Spectre",
              },
              w = {
                '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
                "Search current word",
              },
              p = {
                '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
                "Search current file",
              },
            },
          },
        })
      ''))
    ];
    extraConfig = concatStringsSep "\n" [
      ''
        set ignorecase
        vnoremap ${keyboard.text.dedent} <gv
        vnoremap ${keyboard.text.indent} >gv
        set clipboard+=unnamedplus
        set updatetime=100
        set scrolloff=0
        let g:loaded_perl_provider = 0

        set title
        set titlestring=\ %{substitute(getcwd(),\ $HOME,\ '~',\ '''''')}
      ''
      (omitVIMLInVSCode ''
        set number
        set guifont=monospace:h${pipe config.gui.fonts.monospace.size [floor toString]}
      '')
      (omitVIMLInVSCode "lua require('lsp.index')\n")
    ];
  };
  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./lua;
  };
  xdg.configFile."nvim/lua/luafun" = {
    recursive = true;
    source = luafun;
  };
}
