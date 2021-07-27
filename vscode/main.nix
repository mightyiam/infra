pkgs: {
  enable = true;
  package = pkgs.vscodium;
  userSettings = {
    "editor.cursorSmoothCaretAnimation" = true;
    "editor.smoothScrolling" = true;
    "workbench.list.smoothScrolling" = true;

    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "${pkgs.rnix-lsp}/bin/rnix-lsp";

    "vscode-neovim.neovimExecutablePaths.linux" = "${pkgs.neovim}/bin/nvim";
  };
  extensions = builtins.concatLists [
    (with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
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
}
