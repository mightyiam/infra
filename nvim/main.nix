vimPlugins:
let
  omitInVSCode = viml: builtins.concatStringsSep "" [
    "if !exists('g:vscode')\n"
    viml
    "endif"
  ];
in {
  enable = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  plugins = with vimPlugins; [
    {
      plugin = vim-nix;
      optional = true;
    }
    vim-easymotion
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
  ];
  extraConfig = builtins.concatStringsSep "\n" [
    ''
      set ignorecase
      let mapleader = ","
      vnoremap < <gv
      vnoremap > >gv
      set clipboard+=unnamedplus
    ''
    (omitInVSCode ''
      set number

      :packadd vim-nix
      :packadd lightline-vim 
      :packadd nerdtree
      :packadd nerdtree-git-plugin
    '')
  ];
}
