{
  nixvim,
  lib,
  ...
}: {
  armilaria = {
    plugins.mini-files = {
      enable = true;
      settings.mappings = {
        go_in = "";
        go_in_plus = "l";
        synchronize = "<CR>";
      };
    };
    keymaps =
      {
        "." = "vim.api.nvim_buf_get_name(0)";
        "/" = "";
      }
      |> lib.mapAttrsToList (
        key: openArg: {
          key = "<leader>${key}";
          action = nixvim.mkRaw ''
            function()
              if vim.bo.filetype == "minifiles" then
                MiniFiles.close()
                return
              end

              MiniFiles.open(${openArg})
            end
          '';
          options.desc = "file manager";
        }
      );
  };
}
