{inputs, ...}: {
  imports = [(inputs.treefmt-nix + "/flake-module.nix")];

  perSystem = {
    treefmt = {
      #projectRootFile = "flake.nix";
      programs = {
        prettier.enable = true;
        alejandra.enable = true;
      };
      settings.on-unmatched = "fatal";
    };

    pre-commit.settings.hooks.treefmt.enable = true;
  };
}
