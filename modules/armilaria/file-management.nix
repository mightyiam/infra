{nixvim, ...}: {
  armilaria = {pkgs, ...}: {
    extraPlugins = [pkgs.vimPlugins.nvim-genghis pkgs.vimPlugins.mkdir-nvim];

    extraConfigLua = ''
      require('genghis').setup(${
        nixvim.lua.toLuaObject {
          fileOperations = {
            trashCmd = nixvim.mkRaw ''function() return "rm" end'';
            ignoreInFolderSelection = [];
          };
          navigation = {
            ignoreDotFiles = false;
            ignoreExt = [];
            ignoreFilesWithName = [];
          };
        }
      })
    '';

    keymaps =
      [
        {
          key = "C";
          action = "createNewFile";
          options.desc = "create here";
        }
        {
          key = "c";
          action = "createNewFileInFolder";
          options.desc = "create";
        }
        {
          key = "d";
          action = "duplicateFile";
          options.desc = "duplicate";
        }
        {
          key = "c";
          mode = "v";
          action = "moveSelectionToNewFile";
          options.desc = "move selection to";
        }
        {
          key = "r";
          action = "renameFile";
          options.desc = "rename";
        }
        {
          key = "M";
          action = "moveToFolderInCwd";
          options.desc = "move to";
        }
        {
          key = "m";
          action = "moveAndRenameFile";
          options.desc = "move";
        }
        {
          key = "x";
          action = "chmodx";
          options.desc = "make executable";
        }
        {
          key = "d";
          action = "trashFile";
          options.desc = "remove";
        }
      ]
      |> map (
        keymap:
          keymap
          // {
            key = "<leader>f${keymap.key}";
            action = "<CMD>Genghis ${keymap.action}<CR>";
          }
      );
  };
}
