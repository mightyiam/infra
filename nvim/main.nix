pkgs: {
  enable = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  plugins = with pkgs.vimPlugins; [
    vim-nix
    vim-easymotion
    editorconfig-vim
    {
      plugin = nerdtree;
      config = ''
        nnoremap <leader>n :NERDTreeFocus<CR>
        nnoremap <C-n> :NERDTree<CR>
        nnoremap <C-t> :NERDTreeToggle<CR>
        nnoremap <C-f> :NERDTreeFind<CR>

        " Exit Vim if NERDTree is the only window remaining in the only tab.
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
      '';
    }
    {
      plugin = nerdtree-git-plugin;
      config = ''
        let g:NERDTreeGitStatusUseNerdFonts = 1
      '';
    }
  ];
  extraConfig = ''
    set ignorecase
    let mapleader = ","
    vnoremap < <gv
    vnoremap > >gv
    set clipboard+=unnamedplus
    set number
  '';
}
