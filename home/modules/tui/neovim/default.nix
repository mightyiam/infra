with builtins;
  instance: {
    pkgs,
    config,
    ...
  }: let
    keyboard = import ../../../keyboard.nix;
    omitVIMLInVSCode = import ./omitVIMLInVSCode.nix;
    omitPluginInVSCode = import ./omitPluginInVSCode.nix;
    inlineLuaFile = path:
      concatStringsSep "" [
        "lua << EOF\n"
        (readFile path)
        "EOF\n"
      ];
    font = (import ../../../fonts.nix).monospace;
    pipe = pkgs.lib.trivial.pipe;
    mkBefore = pkgs.lib.mkBefore;
    gruvbox = (import ../../../gruvbox.nix).vim pkgs;
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
    embedLua = lua: ''
      lua << EOF
      ${lua}EOF
    '';
  in
    with keyboard; {
      xdg.configFile."nvim/init.lua".text =
        mkBefore ''
          vim.cmd [[let mapleader = "${leader}"]]'';
      programs.neovim = {
        enable = true;
        vimAlias = true;
        vimdiffAlias = true;
        plugins = with pkgs.vimPlugins; [
          (omitPluginInVSCode gruvbox.plugin gruvbox.config)
          (omitPluginInVSCode vim-nix "")
          {
            plugin = vim-easymotion;
            config = ''
              map ${easyMotion} <Plug>(easymotion-prefix)
            '';
          }
          (omitPluginInVSCode ctrlp-vim ''
            let g:ctrlp_user_command = ['.git', 'cd %s && ${pkgs.git}/bin/git ls-files -co --exclude-standard']
          '')
          (omitPluginInVSCode nvim-treesitter.withAllGrammars (embedLua ''
            require'nvim-treesitter.configs'.setup {
              auto_install = false,
              highlight = {
                enable = true,
              }
            }
          ''))
          {
            plugin = guess-indent-nvim;
            config = embedLua ''
              require('guess-indent').setup {}
            '';
          }
          (omitPluginInVSCode lualine-nvim (embedLua ''
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
          (omitPluginInVSCode nerdtree ''
            nnoremap ${fileTreeFocus} :NERDTreeFocus<CR>
            nnoremap ${fileTreeToggle} :NERDTreeToggle<CR>
          '')
          (omitPluginInVSCode nerdtree-git-plugin ''
            let g:NERDTreeGitStatusUseNerdFonts = 1
          '')
          (omitPluginInVSCode vim-gitgutter "")
          (omitPluginInVSCode nvim-lspconfig "")
          (omitPluginInVSCode rust-tools-nvim "")
          (omitPluginInVSCode cmp-nvim-lsp "")
          (omitPluginInVSCode nvim-cmp "")
          (omitPluginInVSCode luasnip "")
          (omitPluginInVSCode nvim-autopairs (embedLua ''
            require("nvim-autopairs").setup{}
          ''))
          (omitPluginInVSCode lsp-zero ''
            nnoremap ${show.type} <cmd>lua vim.lsp.buf.hover()<CR>
            nnoremap ${show.signature} <cmd>lua vim.lsp.buf.signature_help()<CR>
            nnoremap ${goTo.definition} <cmd>lua vim.lsp.buf.definition()<CR>
            nnoremap ${goTo.declaration} <cmd>lua vim.lsp.buf.declaration()<CR>
            nnoremap ${goTo.implementation} <cmd>lua vim.lsp.buf.implementation()<CR>
            nnoremap ${goTo.type} <cmd>lua vim.lsp.buf.type_definition()<CR>
            nnoremap ${goTo.diagnostics} <cmd>lua vim.diagnostic.setloclist()<CR>
            nnoremap ${refactor.rename} <cmd>lua vim.lsp.buf.rename()<CR>
            nnoremap ${refactor.actions} <cmd>lua vim.lsp.buf.code_action()<CR>
            xnoremap ${refactor.actions} <cmd>lua vim.lsp.buf.code_action()<CR>
            nnoremap ${refactor.format} <cmd>lua vim.lsp.buf.format({ async = false })<CR>
            nnoremap ${diagnostic.next} <cmd>lua vim.diagnostic.goto_next()<CR>
            nnoremap ${diagnostic.prev} <cmd>lua vim.diagnostic.goto_prev()<CR>
          '')
          (omitPluginInVSCode fidget-nvim (inlineLuaFile ./lua/lsp/fidget-nvim.lua))
          (omitPluginInVSCode symbols-outline-nvim "")
          plenary-nvim
          (omitPluginInVSCode null-ls-nvim (inlineLuaFile ./lua/lsp/null-ls.lua))
          (omitPluginInVSCode telescope-nvim (embedLua ''
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
          (omitPluginInVSCode nvim-web-devicons "") # for trouble-nvim
          (omitPluginInVSCode trouble-nvim ''
            lua << EOF
              require("trouble").setup {}
            EOF
            nnoremap ${diagnostic.toggle} <cmd>TroubleToggle<cr>
            nnoremap ${diagnostic.workspace} <cmd>TroubleToggle workspace_diagnostics<cr>
            nnoremap ${diagnostic.document} <cmd>TroubleToggle document_diagnostics<cr>
            nnoremap ${diagnostic.quickfix} <cmd>TroubleToggle quickfix<cr>
            nnoremap ${diagnostic.loclist} <cmd>TroubleToggle loclist<cr>
            nnoremap ${goTo.references} <cmd>TroubleToggle lsp_references<cr>
          '')
          (omitPluginInVSCode vim-autoread ''
            autocmd VimEnter * nested WatchForChangesAllFile!
          '')
          (omitPluginInVSCode unicode-vim "")
          (omitPluginInVSCode which-key-nvim (embedLua ''
            require("which-key").setup {}
          ''))
        ];
        extraConfig = concatStringsSep "\n" [
          ''
            set ignorecase
            vnoremap ${text.dedent} <gv
            vnoremap ${text.indent} >gv
            set clipboard+=unnamedplus
            set updatetime=100
            set scrolloff=8
            let g:loaded_perl_provider = 0

            set title
            set titlestring=\ %{substitute(getcwd(),\ $HOME,\ '~',\ '''''')}
          ''
          (omitVIMLInVSCode ''
            set number
            set guifont=monospace:h${pipe font.size [floor toString]}
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
