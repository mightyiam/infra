{
  inputs,
  nixvim,
  lib,
  ...
}: {
  flake-file.inputs.better-goto-file-nvim = {
    flake = false;
    url = "github:vE5li/better-goto-file.nvim";
  };

  perSystem = {
    nixpkgs.overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins.extend (final': prev': {
          # TODO upstream
          better-goto-file-nvim = prev.vimUtils.buildVimPlugin {
            pname = "better-goto-file-nvim";
            version = "unstable";
            src = inputs.better-goto-file-nvim;
          };
        });
      })
    ];
  };

  armilaria = {pkgs, ...}: {
    extraPlugins = [pkgs.vimPlugins.better-goto-file-nvim];
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
      )
      |> lib.concat [
        {
          key = "<leader>gf";
          action = nixvim.mkRaw ''
            function() require("better-goto-file").goto_file() end
          '';
          options.desc = "Better go to file under cursor";
        }
        {
          key = "<leader>gf";
          mode = "v";
          action = ''
            <Esc>:lua require("better-goto-file").goto_file_range()<cr>
          '';
          options.desc = "Better go to file in selection";
        }

        {
          key = "<C-w><leader>gf";
          action = nixvim.mkRaw ''
            function() require("better-goto-file").goto_file({ gf_command = "<C-w>f" }) end
          '';
          options.desc = "Better go to file under cursor in new split";
        }

        {
          key = "<C-w><leader>gf";
          mode = "v";
          action = ''
            <Esc>:lua require("better-goto-file").goto_file_range({ gf_command = "<C-w>f" })<cr>
          '';
          options.desc = "Better go to file in selection in new split";
        }

        {
          key = "<C-w><leader>gF";
          action = nixvim.mkRaw ''
            function() require("better-goto-file").goto_file({ gf_command = "<C-w>gf" }) end
          '';
          options.desc = "Better go to file under cursor in new tab";
        }
        {
          key = "<C-w><leader>gF";
          mode = "v";
          action = ''
            <Esc>:lua require("better-goto-file").goto_file_range({ gf_command = "<C-w>gf" })<cr>
          '';
          options.desc = "Better go to file in selection in new tab";
        }
      ];
  };
}
