{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    alejandra
    rnix-lsp
    stylua
    lua-language-server
    mob
  ];
}
