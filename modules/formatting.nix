{ inputs, ... }:
{
  imports = [ (inputs.treefmt-nix + "/flake-module.nix") ];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        prettier.enable = true;
        shfmt.enable = true;
      };
      settings = {
        on-unmatched = "fatal";
        global.excludes = [
          "*.jpg"
          "*.png"
          "LICENSE"
        ];
      };
    };
    pre-commit.settings.hooks.treefmt.enable = true;
  };

  flake.modules.nixvim.base = nixvimArgs: {
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
