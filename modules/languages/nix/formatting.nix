{ inputs, ... }:
{
  flake.modules.nixvim.astrea =
    { pkgs, ... }:
    {
      extraConfigLua = ''
        vim.g.nixfmt_enabled = false
      '';

      keymaps = [
        {
          key = "<leader>n";
          options.desc = "Toggle nixfmt";
          action = inputs.nixvim.lib.nixvim.mkRaw ''
            function()
              vim.g.nixfmt_enabled = not vim.g.nixfmt_enabled

              local message
              if vim.g.nixfmt_enabled then
                message = "Nixfmt is on"
              else
                message = "Nixfmt is off"
              end
              vim.notify(message, vim.log.levels.INFO)
            end
          '';
        }
      ];

      plugins.none-ls = {
        enable = true;
        sources.formatting.nixfmt = {
          enable = true;
          package = pkgs.nixfmt-rfc-style;
          settings.runtime_condition = inputs.nixvim.lib.nixvim.mkRaw ''
            function() return vim.g.nixfmt_enabled end
          '';
        };
      };
    };
}
