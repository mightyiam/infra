with builtins;
  instance: {
    pkgs,
    lib,
    ...
  }: let
    pipe = lib.trivial.pipe;
    foldr = lib.lists.foldr;
    mergeAttrs = lib.trivial.mergeAttrs;
    settings = {
      "editor.cursorSmoothCaretAnimation" = true;
      "editor.smoothScrolling" = true;
      "workbench.list.smoothScrolling" = true;
      "diffEditor.renderSideBySide" = false;
    };
    extensions = with pkgs.vscode-extensions; [
      {
        package = jnoortheen.nix-ide;
        settings = {
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${pkgs.rnix-lsp}/bin/rnix-lsp";
        };
      }
      {
        package = asvetliakov.vscode-neovim;
        settings = {
          "vscode-neovim.neovimExecutablePaths.linux" = "${pkgs.neovim}/bin/nvim";
        };
      }
      {
        package = dbaeumer.vscode-eslint;
        settings = {};
      }
    ];
  in {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      userSettings =
        mergeAttrs
        settings
        (pipe extensions [
          (map ({settings, ...}: settings))
          (foldr mergeAttrs {})
        ]);
      extensions = map ({package, ...}: package) extensions;
      keybindings = [
        {
          key = "ctrl+k f";
          command = "-workbench.action.closeFolder";
          when = "emptyWorkspaceSupport";
        }
        {
          key = "ctrl+k f";
          command = "workbench.explorer.fileView.focus";
        }
      ];
    };
  }
