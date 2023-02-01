{pkgs ? import <nixpkgs> {}}: let
  shared = {
    buildInputs = with pkgs; [
      alejandra
      rnix-lsp
      stylua
      sumneko-lua-language-server
    ];
  };
  local_path = ./local.nix;
  local =
    if builtins.pathExists local_path
    then (import local_path) {inherit pkgs;}
    else {};
  merged = pkgs.lib.recursiveUpdate shared local;
in
  pkgs.mkShell merged
