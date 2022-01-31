{ pkgs, ... }:
let
  omitInVSCode = import ./omitInVSCode.nix;
  inlineLuaFile = path: builtins.concatStringsSep "\n" [
    "lua << EOF"
    (builtins.readFile path)
    "EOF"
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
        config = omitInVSCode ''
          :packadd vim-nix
        '';
      }
      vim-easymotion
      {
        plugin = ctrlp-vim;
        optional = true;
        config = omitInVSCode ''
          :packadd ctrlp.vim
          let g:ctrlp_show_hidden = 1
        '';
      }
      editorconfig-vim
      {
        plugin = lightline-vim;
        optional = true;
        config = omitInVSCode ''
          :packadd lightline.vim 
          set noshowmode
        '';
      }
      {
        plugin = nerdtree;
        optional = true;
        config = omitInVSCode ''
          :packadd nerdtree
          nnoremap <leader>n :NERDTreeFocus<CR>
          nnoremap <C-n> :NERDTree<CR>
          nnoremap <C-t> :NERDTreeToggle<CR>
        '';
      }
      {
        plugin = nerdtree-git-plugin;
        optional = true;
        config = omitInVSCode ''
          :packadd nerdtree-git-plugin
          let g:NERDTreeGitStatusUseNerdFonts = 1
        '';
      }
      {
        plugin = vim-gitgutter;
        optional = true;
        config = omitInVSCode ''
          :packadd vim-gitgutter 
        '';
      }
      {
        plugin = nvim-lspconfig;
        optional = true;
        config = omitInVSCode (builtins.concatStringsSep "\n" [
          "packadd! nvim-lspconfig"
          (inlineLuaFile ./nvim-lspconfig.lua)
        ]);
      }
      {
        plugin = rust-tools-nvim;
        optional = true;
        config = omitInVSCode (builtins.concatStringsSep "\n" [
            "packadd! rust-tools.nvim"
            (inlineLuaFile ./rust-tools.nvim.lua)
        ]);
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
      '')
    ];
  };
}
