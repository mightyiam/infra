{ lib, inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];
  perSystem =
    { self', ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        programs = {
          nixfmt.enable = true;
          prettier.enable = true;
          rustfmt.enable = true;
          shfmt.enable = true;
          yamlfmt.enable = true;
        };
        settings = {
          on-unmatched = "fatal";
          global.excludes = [
            "*.png"
            "*.toml"
            "*/.gitignore"
            "LICENSE"
          ];
        };
      };
      pre-commit.settings.hooks.nix-fmt = {
        enable = true;
        entry = lib.getExe self'.formatter;
      };
    };
}
