{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib)
    foldr
    mergeAttrs
    mkIf
    pipe
    ;

  inherit (pkgs) vscode-extensions;

  settings = {
    "editor.cursorSmoothCaretAnimation" = true;
    "editor.unicodeHighlight.ambiguousCharacters" = false;
    "editor.smoothScrolling" = true;
    "workbench.list.smoothScrolling" = true;
    "diffEditor.renderSideBySide" = false;
  };
  extensions = [
    {
      package = vscode-extensions.jnoortheen.nix-ide;
      settings = {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
      };
    }
    {
      package = vscode-extensions.asvetliakov.vscode-neovim;
      settings = {
        "vscode-neovim.neovimExecutablePaths.linux" = "${pkgs.neovim}/bin/nvim";
      };
    }
    {
      package = vscode-extensions.dbaeumer.vscode-eslint;
      settings = { };
    }
  ];
in
mkIf config.gui.enable {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = mergeAttrs settings (
      pipe extensions [
        (map ({ settings, ... }: settings))
        (foldr mergeAttrs { })
      ]
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
