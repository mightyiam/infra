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
  in {
    xdg.configFile."nvim/init.vim".text = mkBefore ''
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
        editorconfig-vim
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
        (pipe ./lsp.lua [inlineLuaFile omitVIMLInVSCode])
      ];
    };
  }
