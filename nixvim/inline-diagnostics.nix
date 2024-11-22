{ lib, ... }:
{
  plugins = {
    lsp-lines = {
      enable = true;
      luaConfig.post = ''
        vim.diagnostic.config({
          virtual_lines = false,
          virtual_text = true,
        })
      '';
    };
    lsp.keymaps.extra = [
      {
        key = "<leader>l";
        action = lib.nixvim.mkRaw ''
          function()
            local current = vim.diagnostic.config()
            vim.diagnostic.config({
              virtual_lines = not current.virtual_lines,
              virtual_text = not current.virtual_text,
            })
          end
        '';
      }
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
