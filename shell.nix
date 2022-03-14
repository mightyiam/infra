{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    alejandra
    rnix-lsp
    sumneko-lua-language-server
  ];
}
