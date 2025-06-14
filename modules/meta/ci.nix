let
  filePath = ".github/workflows/check.yaml";

  ids = {
    jobs = {
      getCheckNames = "get-check-names";
      check = "check";
    };
    steps.getCheckNames = "get-check-names";
    outputs = {
      jobs.getCheckNames = "checks";
      steps.getCheckNames = "checks";
    };
  };

  matrixParam = "checks";

  nixArgs = "--accept-flake-config";

  runner = {
    name = "ubuntu-latest";
    system = "x86_64-linux";
  };

  steps = {
    nothingButNix = {
      uses = "wimpysworld/nothing-but-nix@main";
      "with" = {
        hatchet-protocol = "holster";
      };
    };
    checkout = {
      uses = "actions/checkout@v4";
      "with".submodules = true;
    };
    detsysNixInstaller.uses = "DeterminateSystems/nix-installer-action@main";
    magicNixCache.uses = "DeterminateSystems/magic-nix-cache-action@main";
  };
in
{
  perSystem =
    { pkgs, ... }:
    {
      files.files.${filePath} = pkgs.writers.writeJSON "gh-actions-workflow-check.yaml" {
        on = {
          push = { };
          workflow_call = { };
        };
        jobs = {
          ${ids.jobs.getCheckNames} = {
            runs-on = runner.name;
            outputs.${ids.outputs.jobs.getCheckNames} =
              "\${{ steps.${ids.steps.getCheckNames}.outputs.${ids.outputs.steps.getCheckNames} }}";
            steps = [
              steps.checkout
              steps.detsysNixInstaller
              steps.magicNixCache
              {
                id = ids.steps.getCheckNames;
                run = ''
                  checks="$(nix ${nixArgs} eval --json .#checks.${runner.system} --apply builtins.attrNames)"
                  echo "${ids.outputs.steps.getCheckNames}=$checks" >> $GITHUB_OUTPUT
                '';
              }
            ];
          };

          ${ids.jobs.check} = {
            needs = ids.jobs.getCheckNames;
            runs-on = runner.name;
            strategy.matrix.${matrixParam} =
              "\${{ fromJson(needs.${ids.jobs.getCheckNames}.outputs.${ids.outputs.jobs.getCheckNames}) }}";
            steps = [
              steps.checkout
              steps.nothingButNix
              steps.detsysNixInstaller
              steps.magicNixCache
              {
                run = ''
                  nix ${nixArgs} build '.#checks.${runner.system}."''${{ matrix.${matrixParam} }}"'
                '';
              }
            ];
          };
        };
      };

      treefmt.settings.global.excludes = [ filePath ];
    };
}
