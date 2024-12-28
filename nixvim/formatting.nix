{ lib, pkgs, ... }:
{
  plugins = {
    lsp.keymaps.lspBuf."<space>f" = "format";

    lsp-format = {
      enable = true;
      lspServersToEnable = "none";
    };

    none-ls = {
      enable = true;

      package = pkgs.vimPlugins.none-ls-nvim.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [
          # https://github.com/nvimtools/none-ls.nvim/pull/192
          (pkgs.fetchpatch {
            name = "Add 'nix flake fmt' builtin formatter";
            url = "https://patch-diff.githubusercontent.com/raw/nvimtools/none-ls.nvim/pull/192.diff";
            hash = "sha256-F32gixa54g2o2G+L6ZGJv7+ldTbYoszvasOgCdtPwlE=";
          })
        ];
      });

      # Note: nixvim will generate a nice nixified option for this once
      # https://github.com/nvimtools/none-ls.nvim/pull/192 lands in none-ls.
      settings.sources = [ ''require("null-ls").builtins.formatting.nix_flake_fmt'' ];
    };
  };

  keymaps = [
    {
      key = "<leader>a";
      options.desc = "Toggle autoformatting";
      action = lib.nixvim.mkRaw ''
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
}
