with builtins;
  viml:
    concatStringsSep "\n" [
      "if !exists('g:vscode')"
      (concatStringsSep "" [viml "endif"])
    ]
