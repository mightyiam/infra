{
  armilaria = nixvimArgs: {
    plugins = {
      lsp-format.enable = true;

      none-ls = {
        enable = true;
        sources.formatting.nix_flake_fmt.enable = true;
      };
    };

    keymaps = [
      {
        key = "<space>f";
        mode = "n";
        action = "<cmd>Format<CR>";
      }
      {
        key = "<leader>tf";
        options.desc = "Toggle lsp-format autoformatting";
        action = nixvimArgs.lib.nixvim.mkRaw ''
          function()
            local lsp_format = require("lsp-format")

            lsp_format.disabled = not lsp_format.disabled

            local message
            if lsp_format.disabled then
              message = "lsp-format autoformatting OFF"
            else
              message = "lsp-format autoformatting ON"
            end
            vim.notify(message, vim.log.levels.INFO)
          end
        '';
      }
    ];
  };
}
