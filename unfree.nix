with builtins; { lib, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg: elem (lib.getName pkg) [
    "vscode-extension-ms-vsliveshare-vsliveshare"
  ];
}
