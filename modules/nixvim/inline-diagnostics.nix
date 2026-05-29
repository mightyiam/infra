{
  flake.modules.nixvim.base = nixvimArgs: {
    plugins.tiny-inline-diagnostic = {
      enable = true;
      settings.options.show_diags_only_under_cursor = true;
    };
    lsp.keymaps = [
      {
        key = "[d";
        action = nixvimArgs.lib.nixvim.mkRaw ''
          function()
            vim.diagnostic.goto_prev({ float = false })
          end
        '';
      }
      {
        key = "]d";
        action = nixvimArgs.lib.nixvim.mkRaw ''
          function()
            vim.diagnostic.goto_next({ float = false })
          end
        '';
      }
      {
        key = "<leader>de";
        action = "<cmd>TinyInlineDiag enable<cr>";
        options.desc = "Enable diagnostics";
      }
      {
        key = "<leader>dd";
        action = "<cmd>TinyInlineDiag disable<cr>";
        options.desc = "Disable diagnostics";
      }
      {
        key = "<leader>td";
        action = "<cmd>TinyInlineDiag toggle<cr>";
        options.desc = "Toggle diagnostics";
      }
      {
        key = "<leader>tcd";
        action = "<cmd>TinyInlineDiag toggle_cursor_only<cr>";
        options.desc = "Toggle cursor-only diagnostics";
      }
      {
        key = "<leader>dr";
        action = "<cmd>TinyInlineDiag reset<cr>";
        options.desc = "Reset diagnostic options";
      }
    ];
  };
}
