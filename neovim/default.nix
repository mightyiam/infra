{ pkgs, ... }:
let
  omitInVSCode = import ./omitInVSCode.nix;
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
        config = omitInVSCode ''
          let g:ctrlp_show_hidden = 1
        '';
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
      {
        plugin = nvim-lspconfig;
        optional = true;
        config = omitInVSCode ''
          packadd! nvim-lspconfig
          lua << EOF
          local nvim_lsp = require('lspconfig')

          -- Use an on_attach function to only map the following keys
          -- after the language server attaches to the current buffer
          local on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            -- Enable completion triggered by <c-x><c-o>
            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            local opts = { noremap=true, silent=true }

            -- See `:help vim.lsp.*` for documentation on any of the below functions
            buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
            buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
            buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
            buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

          end

          -- Use a loop to conveniently call 'setup' on multiple servers and
          -- map buffer local keybindings when the language server attaches
          local servers = { 'rust_analyzer' }
          for _, lsp in ipairs(servers) do
            nvim_lsp[lsp].setup {
              on_attach = on_attach,
              flags = {
                debounce_text_changes = 150,
              }
            }
          end
          EOF
        '';
      }
      {
        plugin = rust-tools-nvim;
        optional = true;
        config = omitInVSCode ''
          packadd! rust-tools.nvim
          lua << EOF
          require('rust-tools').setup({})
          EOF
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
