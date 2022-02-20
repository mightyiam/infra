with builtins; { pkgs, ... }:
let 
  nixpkgsClone = import (fetchTarball "https://api.github.com/repos/NixOS/nixpkgs/tarball/65a010bcead26c971fe5b01bb02c4a9f02d02271") {};
in {
  programs.vscode = {
    enable = true;
    package = nixpkgsClone.vscodium;
    userSettings = {
      "editor.cursorSmoothCaretAnimation" = true;
      "editor.smoothScrolling" = true;
      "workbench.list.smoothScrolling" = true;
      "diffEditor.renderSideBySide" = false;

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "${pkgs.rnix-lsp}/bin/rnix-lsp";

      "vscode-neovim.neovimExecutablePaths.linux" = "${pkgs.neovim}/bin/nvim";
    };
    extensions = concatLists [
      (with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        dbaeumer.vscode-eslint
        ms-vsliveshare.vsliveshare
      ])
      (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-neovim";
          publisher = "asvetliakov";
          version = "0.0.82";
          sha256 = "6149728023e5785fbf4edc9dd8f79e6c0a1991c0211666ad6c78b59dde97c09d";
        }
      ])
    ];
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

