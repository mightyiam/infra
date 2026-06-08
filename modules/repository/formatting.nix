{
  inputs,
  lib,
  ...
}: {
  flake-file = {
    inputs.treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      flake = false;
    };
    formatter = lib.getAttr "alejandra";
  };

  imports = [(inputs.treefmt-nix + "/flake-module.nix")];

  perSystem = {
    treefmt = {
      programs = {
        prettier.enable = true;
        alejandra.enable = true;
      };
      settings.on-unmatched = "fatal";
    };

    pre-commit.settings.hooks.treefmt.enable = true;
  };
}
