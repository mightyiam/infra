{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];
  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";
      programs.nixfmt.enable = true;
      programs.mdformat.enable = true;
      programs.rustfmt.enable = true;
      programs.shfmt.enable = true;
      programs.stylua.enable = true;
      programs.yamlfmt.enable = true;
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
