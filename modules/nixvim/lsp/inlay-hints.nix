{
  flake.modules.nixvim.base = nixvimArgs: {
    plugins.lsp = {
      inlayHints = true;
      keymaps.extra = [
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
