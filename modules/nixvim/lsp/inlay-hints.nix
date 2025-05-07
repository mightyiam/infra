{ inputs, ... }:
{
  flake.modules.nixvim.astrea.plugins.lsp = {
    inlayHints = true;
    keymaps.extra = [
      {
        key = "<leader>ht";
        mode = "n";
        action = inputs.nixvim.lib.nixvim.mkRaw ''
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end
        '';
      }
    ];
  };
}
