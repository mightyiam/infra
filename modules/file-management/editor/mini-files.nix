{ nixvim, inputs, ... }:
{
  flake.modules.nixvim.base =
    { pkgs, ... }:
    {
      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          pname = "nvim-genghis";
          version = "0-unstable";
          src = inputs.nvim-genghis;
        })
      ];

      plugins.mini-files = {
        enable = true;
        settings.mappings = {
          go_in = "";
          go_in_plus = "l";
          synchronize = "<CR>";
        };
      };
      keymaps = [
        {
          key = "<leader>.";
          action = nixvim.mkRaw ''
            function()
              if vim.bo.filetype == "minifiles" then
                MiniFiles.close()
                return
              end

              MiniFiles.open(vim.api.nvim_buf_get_name(0))
            end
          '';
          options.desc = "file manager";
        }
      ];
    };
}
