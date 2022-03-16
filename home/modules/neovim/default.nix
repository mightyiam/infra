with builtins;
  {
    pkgs,
    config,
    ...
  }: let
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
      version = "3b6387e242c9441f5ad008aff150c8b882fd86f3";
      src = pkgs.fetchFromGitHub {
        owner = "VonHeikemen";
        repo = "lsp-zero.nvim";
        rev = version;
        sha256 = "pSoY2k28+oE2GjkiP6kpthH3ekJ5ybjT7aYYz6kGPgs=";
      };
    };
    luafun = pkgs.fetchFromGitHub {
      owner = "luafun";
      repo = "luafun";
      rev = "0.1.3";
      sha256 = "aOriC7VD29XzchvLOfmySNDR1MtO1xrqHYABRMaDoJo=";
    };
  in {
    xdg.configFile."nvim/init.vim".text =
      mkBefore ''
        let mapleader = ","'';
    programs.neovim = {
      enable = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        (omitPluginInVSCode gruvbox.plugin gruvbox.config)
        (omitPluginInVSCode vim-nix "")
        vim-easymotion
        (omitPluginInVSCode ctrlp-vim ''
          let g:ctrlp_show_hidden = 1
        '')
        editorconfig-nvim
        (omitPluginInVSCode lightline-vim ''
          set noshowmode
        '')
        (omitPluginInVSCode nerdtree ''
          nnoremap <leader>n :NERDTreeFocus<CR>
          nnoremap <C-n> :NERDTree<CR>
          nnoremap <C-t> :NERDTreeToggle<CR>
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
        (omitPluginInVSCode lsp-zero "")
      ];
      extraConfig = concatStringsSep "\n" [
        ''
          set ignorecase
          vnoremap < <gv
          vnoremap > >gv
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
