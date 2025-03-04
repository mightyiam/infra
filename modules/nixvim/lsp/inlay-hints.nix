{ lib, ... }:
{
  plugins.lsp = {
    inlayHints = true;
    keymaps.extra = [
      {
        key = "<leader>ht";
        mode = "n";
        action = lib.nixvim.mkRaw ''
          function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end
        '';
      }
    ];
  };
}
