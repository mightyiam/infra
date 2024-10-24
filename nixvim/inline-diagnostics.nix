{ lib, ... }:
{
  plugins = {
    lsp-lines = {
      enable = true;
      luaConfig.post = ''
        vim.diagnostic.config({ virtual_text = false })
      '';
    };
    lsp.keymaps.extra = [
      {
        key = "[d";
        action = lib.nixvim.mkRaw ''
          function()
            vim.diagnostic.goto_prev({ float = false })
          end
        '';
      }
      {
        key = "]d";
        action = lib.nixvim.mkRaw ''
          function()
            vim.diagnostic.goto_next({ float = false })
          end
        '';
      }
    ];
  };
}
