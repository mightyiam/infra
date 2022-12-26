with builtins;
  instance: {
    pkgs,
    config,
    ...
  }: let
    keyboard = import ../../keyboard.nix;
    omitVIMLInVSCode = import ./omitVIMLInVSCode.nix;
    omitPluginInVSCode = import ./omitPluginInVSCode.nix;
    inlineLuaFile = path:
      concatStringsSep "" [
        "lua << EOF\n"
        (readFile path)
        "EOF\n"
      ];
    font = (import ../../fonts.nix).monospace;
    pipe = pkgs.lib.trivial.pipe;
    mkBefore = pkgs.lib.mkBefore;
    gruvbox = (import ../../gruvbox.nix).vim pkgs;
    lsp-zero = pkgs.vimUtils.buildVimPlugin rec {
      pname = "lsp-zero";
      version = "c283c02735a460c52d9dcf1e5ce56de0efec4c9e";
      src = pkgs.fetchFromGitHub {
        owner = "VonHeikemen";
        repo = "lsp-zero.nvim";
        rev = version;
        sha256 = "/olrokwin7T/v12Ml11Wo14BwS/lXOIDoWcYorj1c3o=";
      };
    };
    vim-autoread = pkgs.vimUtils.buildVimPlugin rec {
      pname = "vim-autoread";
      version = "7e83d47a71fdafc271005fc39c89863204278c77";
      src = pkgs.fetchFromGitHub {
        owner = "djoshea";
        repo = "vim-autoread";
        rev = version;
        sha256 = "IGgJ/D2AGDtbO+RZk2zd+zO9ZtANsle4QSjsh+VOXpg=";
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
          editorconfig-nvim
          (omitPluginInVSCode lightline-vim ''
            set noshowmode
          '')
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
          {
            plugin = nvim-autopairs;
            config = embedLua ''
              require("nvim-autopairs").setup{}
            '';
          }
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
          plenary-nvim # dependency of null-ls-nvim
          (omitPluginInVSCode null-ls-nvim (inlineLuaFile ./lua/lsp/null-ls.lua))
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
        ];
        extraConfig = concatStringsSep "\n" [
          ''
            set ignorecase
            vnoremap ${text.dedent} <gv
            vnoremap ${text.indent} >gv
            set clipboard+=unnamedplus
            set updatetime=100
            set scrolloff=8
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
