{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    alejandra
    rnix-lsp
    stylua
    sumneko-lua-language-server
    mob
  ];
}
