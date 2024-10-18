viml:
builtins.concatStringsSep "\n" [
  "if !exists('g:vscode')"
  (builtins.concatStringsSep "" [
    viml
    "endif\n"
  ])
]
