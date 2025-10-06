{
  flake.modules.nixvim.base.plugins.telescope.keymaps = {
    "<leader>ff" = {
      action = "find_files";
    };
    "<leader>fg" = {
      action = "live_grep";
    };
    "<leader>fb" = {
      action = "buffers";
    };
    "<leader>fh" = {
      action = "help_tags";
    };
    "<leader>fc" = {
      action = "commands";
    };
    "<leader>fq" = {
      action = "quickfix";
    };
    "<leader>fk" = {
      action = "keymaps";
    };
    "<leader>fr" = {
      action = "lsp_references";
    };
    "<leader>fds" = {
      action = "lsp_document_symbols";
    };
    "<leader>fs" = {
      action = "lsp_workspace_symbols";
    };
    "<leader>fp" = {
      action = "diagnostics";
    };
    "<leader>fi" = {
      action = "lsp_implementations";
    };
    "<leader>fd" = {
      action = "lsp_definitions";
    };
    "<leader>ft" = {
      action = "lsp_type_definitions";
    };
    "<leader>fa" = {
      action = "builtin";
    };
    "<leader>f;" = {
      action = "resume";
    };
  };
}
