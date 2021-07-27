pkgs: {
  enable = true;
  package = pkgs.vscodium;
  extensions = with pkgs.vscode-extensions; [
    vscodevim.vim
  ];
}
