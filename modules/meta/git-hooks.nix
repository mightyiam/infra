{ inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];

  files.".gitignore".parts."pre-commit-config.yaml" = ''
    /.pre-commit-config.yaml
  '';

  perSystem =
    { config, ... }:
    {
      make-shells.default.shellHook = config.pre-commit.installationScript;
      pre-commit.check.enable = false;
    };
}
