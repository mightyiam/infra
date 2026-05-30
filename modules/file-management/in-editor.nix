{ nixvim, ... }:
{
  flake.modules.nixvim.base = {
    plugins.mini-files.enable = true;
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
