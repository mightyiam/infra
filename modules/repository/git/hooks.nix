{inputs, ...}: {
  imports = [(inputs.git-hooks + "/flake-module.nix")];

  git.ignore = ["/.pre-commit-config.yaml"];

  perSystem = {config, ...}: {
    make-shells.default.shellHook = config.pre-commit.installationScript;
    pre-commit.check.enable = false;
  };
}
