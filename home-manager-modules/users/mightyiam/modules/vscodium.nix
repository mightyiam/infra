{
  pkgs,
  config,
  lib,
  ...
}:
let
  settings = {
    "editor.cursorSmoothCaretAnimation" = true;
    "editor.unicodeHighlight.ambiguousCharacters" = false;
    "editor.smoothScrolling" = true;
    "workbench.list.smoothScrolling" = true;
    "diffEditor.renderSideBySide" = false;
  };
  extensions = [
    {
      package = pkgs.vscode-extensions.jnoortheen.nix-ide;
      settings = {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
      };
    }
    {
      package = pkgs.vscode-extensions.asvetliakov.vscode-neovim;
      settings = {
        "vscode-neovim.neovimExecutablePaths.linux" = "${pkgs.neovim}/bin/nvim";
      };
    }
    {
      package = pkgs.vscode-extensions.dbaeumer.vscode-eslint;
      settings = { };
    }
  ];
in
lib.mkIf config.gui.enable {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = lib.mergeAttrs settings (
      map ({ settings, ... }: settings) extensions |> lib.foldr lib.mergeAttrs { }
    );
    extensions = map ({ package, ... }: package) extensions;
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
