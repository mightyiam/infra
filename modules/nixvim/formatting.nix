{ inputs, ... }:
{
  flake.modules.nixvim.astrea = {
    plugins = {
      lsp.keymaps.lspBuf."<space>f" = "format";

      lsp-format = {
        enable = true;
        lspServersToEnable = "none";
      };

      none-ls = {
        enable = true;
        sources.formatting.nix_flake_fmt.enable = true;
      };
    };

    keymaps = [
      {
        key = "<leader>a";
        options.desc = "Toggle autoformatting";
        action = inputs.nixvim.lib.nixvim.mkRaw ''
          function()
            local lsp_format = require("lsp-format")

            lsp_format.disabled = not lsp_format.disabled

            local message
            if lsp_format.disabled then
              message = "Autoformatting is off"
            else
              message = "Autoformatting is on"
            end
            vim.notify(message, vim.log.levels.INFO)
          end
        '';
      }
    ];
  };
}
