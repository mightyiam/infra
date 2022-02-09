{ pkgs, ... }:
let
  omitVIMLInVSCode = import ./omitVIMLInVSCode.nix;
  omitPluginInVSCode = import ./omitPluginInVSCode.nix;
  inlineLuaFile = path: builtins.concatStringsSep "" [
    "lua << EOF\n"
    (builtins.readFile path)
    "EOF\n"
  ];
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
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
      (omitPluginInVSCode nvim-lspconfig (inlineLuaFile ./nvim-lspconfig.lua))
      (omitPluginInVSCode rust-tools-nvim (inlineLuaFile ./rust-tools.nvim.lua))
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
      (omitVIMLInVSCode ''
        set number
      '')
    ];
  };
}