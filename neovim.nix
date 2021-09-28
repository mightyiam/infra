{ pkgs, ... }:
let
  omitInVSCode = viml: builtins.concatStringsSep "" [
    "if !exists('g:vscode')\n"
    viml
    "endif"
  ];
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = vim-nix;
        optional = true;
      }
      vim-easymotion
      {
        plugin = ctrlp-vim;
        optional = true;
      }
      editorconfig-vim
      {
        plugin = lightline-vim;
        optional = true;
        config = omitInVSCode ''
          set noshowmode
        '';
      }
      {
        plugin = nerdtree;
        optional = true;
        config = omitInVSCode ''
          nnoremap <leader>n :NERDTreeFocus<CR>
          nnoremap <C-n> :NERDTree<CR>
          nnoremap <C-t> :NERDTreeToggle<CR>
        '';
      }
      {
        plugin = nerdtree-git-plugin;
        optional = true;
        config = omitInVSCode ''
          let g:NERDTreeGitStatusUseNerdFonts = 1
        '';
      }
      {
        plugin = vim-gitgutter;
        optional = true;
      }
    ];
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        set ignorecase
        let mapleader = ","
        vnoremap < <gv
        vnoremap > >gv
        set clipboard+=unnamedplus
        set updatetime=100
      ''
      (omitInVSCode ''
        set number

        :packadd vim-nix
        :packadd ctrlp.vim
        :packadd lightline.vim 
        :packadd nerdtree
        :packadd nerdtree-git-plugin
        :packadd vim-gitgutter 
      '')
    ];
  };
}
