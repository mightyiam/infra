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
    maximizeBuildSpace = {
      uses = "easimon/maximize-build-space@master";
      "with" = {
        remove-dotnet = true;
        remove-android = true;
        remove-haskell = true;
        remove-codeql = true;
        remove-docker-images = true;
      };
    };
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
    installNix.uses = "DeterminateSystems/nix-installer-action@main";
    nixCache.uses = "DeterminateSystems/magic-nix-cache-action@main";
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
              steps.installNix
              steps.nixCache
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
              # steps.maximizeBuildSpace
              steps.checkout
              steps.nothingButNix
              steps.installNix
              steps.nixCache
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
