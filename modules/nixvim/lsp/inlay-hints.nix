{
  flake.modules.nixvim.base = nixvimArgs: {
    lsp = {
      inlayHints.enable = true;
      keymaps = [
        {
          key = "<leader>th";
          mode = "n";
          action = nixvimArgs.lib.nixvim.mkRaw ''
            function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end
          '';
          options.desc = "Toggle inlay hints";
        }
      ];
    };
  };
}
