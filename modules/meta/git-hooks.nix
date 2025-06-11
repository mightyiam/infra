{ inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];

  files.".gitignore" = ''
    /.pre-commit-config.yaml
  '';

  perSystem =
    { config, ... }:
    {
      make-shells.default.shellHook = config.pre-commit.installationScript;
      pre-commit.check.enable = false;
    };
}
