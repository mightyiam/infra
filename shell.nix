{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    rnix-lsp
    sumneko-lua-language-server
    alejandra
  ];
}
