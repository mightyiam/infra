with builtins;
  {
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
      version = "e6f46b68edebbce73a18ab0856df2da703b748b3";
      src = pkgs.fetchFromGitHub {
        owner = "VonHeikemen";
        repo = "lsp-zero.nvim";
        rev = version;
        sha256 = "dY+Zw/woyl5aqe+l44TltAfnSLGQD2gkZzGTOZl/SP4=";
      };
    };
    luafun = pkgs.fetchFromGitHub {
      owner = "luafun";
      repo = "luafun";
      rev = "0.1.3";
      sha256 = "aOriC7VD29XzchvLOfmySNDR1MtO1xrqHYABRMaDoJo=";
    };
  in
    with keyboard; {
      xdg.configFile."nvim/init.vim".text =
        mkBefore ''
          let mapleader = "${leader}"'';
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
            let g:ctrlp_show_hidden = 1
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
          (omitPluginInVSCode lsp-zero ''
            nnoremap ${goTo.declaration} <cmd>lua vim.lsp.buf.declaration()<CR>
            nnoremap ${goTo.definition} <cmd>lua vim.lsp.buf.definition()<CR>
            nnoremap ${goTo.implementation} <cmd>lua vim.lsp.buf.implementation()<CR>
            nnoremap ${goTo.type} <cmd>lua vim.lsp.buf.type_definition()<CR>
            nnoremap ${list.actions} <cmd>lua vim.lsp.buf.code_action()<CR>
            nnoremap ${list.diagnostics} <cmd>lua vim.diagnostic.setloclist()<CR>
            nnoremap ${list.references} <cmd>lua vim.lsp.buf.references()<CR>
            nnoremap ${popup.diagnostics} <cmd>lua vim.diagnostic.open_float()<CR>
            nnoremap ${popup.signature} <cmd>lua vim.lsp.buf.signature_help()<CR>
            nnoremap ${popup.type} <cmd>lua vim.lsp.buf.hover()<CR>
            nnoremap ${prevNext.diagnostic.next} <cmd>lua vim.diagnostic.goto_next()<CR>
            nnoremap ${prevNext.diagnostic.prev} <cmd>lua vim.diagnostic.goto_prev()<CR>
            nnoremap ${refactor.format} <cmd>lua vim.lsp.buf.formatting()<CR>
            nnoremap ${refactor.rename} <cmd>lua vim.lsp.buf.rename()<CR>
            xnoremap ${list.actions} <cmd>lua vim.lsp.buf.range_code_action()<CR>
          '')
          plenary-nvim # dependency of null-ls-nvim
          (omitPluginInVSCode null-ls-nvim (inlineLuaFile ./lua/lsp/null-ls.lua))
        ];
        extraConfig = concatStringsSep "\n" [
          ''
            set ignorecase
            vnoremap ${text.dedent} <gv
            vnoremap ${text.indent} >gv
            set clipboard+=unnamedplus
            set updatetime=100
            set scrolloff=99
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
