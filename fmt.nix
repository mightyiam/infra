{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];
  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
        mdformat.enable = true;
        rustfmt.enable = true;
        shfmt.enable = true;
        stylua.enable = true;
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
      entry = "nix fmt -- --fail-on-change";
    };
  };
}
