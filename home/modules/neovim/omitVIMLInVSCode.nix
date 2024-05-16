let
  inherit
    (builtins)
    concatStringsSep
    ;
in
  viml:
    concatStringsSep "\n" [
      "if !exists('g:vscode')"
      (concatStringsSep "" [viml "endif\n"])
    ]
