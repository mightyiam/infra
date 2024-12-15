{ inputs, ... }:
{
  imports = [ inputs.git-hooks.flakeModule ];
  perSystem =
    { config, ... }:
    {
      devshells.default.devshell.startup.git-hooks.text = config.pre-commit.installationScript;
      pre-commit.check.enable = false;
    };
}
