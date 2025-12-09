{ config, ... }:
let
  inherit (config.flake.meta) repo;
  filename = "check.yaml";
  filePath = ".github/workflows/${filename}";

  workflowName = "Check";

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
        nix-permission-edict = true;
      };
    };
    checkout = {
      uses = "actions/checkout@v4";
      "with".submodules = true;
    };
    installNix = {
      uses = "nixbuild/nix-quick-install-action@master";
      "with" = {
        nix_conf = ''
          keep-env-derivations = true
          keep-outputs = true
        '';
        github_access_token = "\${{ secrets.GITHUB_TOKEN }}";
      };
    };
    cacheNix = {
      uses = "nix-community/cache-nix-action@main";
      "with".primary-key = "nix-\${{ runner.os }}";
    };
  };
in
{
  text.readme.parts = {
    ci-badge = ''
      <a href="https://github.com/${repo.owner}/${repo.name}/actions/workflows/${filename}?query=branch%3A${repo.defaultBranch}">
      <img
        alt="CI status"
        src="https://img.shields.io/${repo.forge}/actions/workflow/status/${repo.owner}/${repo.name}/${filename}?style=for-the-badge&branch=${repo.defaultBranch}&label=${workflowName}"
      >
      </a>

    '';
    github-actions = ''
      ## Running checks on GitHub Actions

      Running this repository's flake checks on GitHub Actions is merely a bonus
      and possibly more of a liability.

      Workflow files are generated using
      [the _files_ flake-parts module](https://github.com/mightyiam/files).

      For better visibility, a job is spawned for each flake check.
      This is done dynamically.

    ''
    + (
      assert steps ? nothingButNix;
      ''
        To prevent runners from running out of space,
        The action [Nothing but Nix](https://github.com/marketplace/actions/nothing-but-nix)
        is used.

      ''
    )
    + ''
      See [`modules/meta/ci.nix`](modules/meta/ci.nix).

    '';
  };

  perSystem =
    { pkgs, ... }:
    {
      files.files = [
        {
          path_ = filePath;
          drv = pkgs.writers.writeJSON "gh-actions-workflow-check.yaml" {
            name = workflowName;
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
                  steps.cacheNix
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
                strategy = {
                  fail-fast = false;
                  matrix.${matrixParam} =
                    "\${{ fromJson(needs.${ids.jobs.getCheckNames}.outputs.${ids.outputs.jobs.getCheckNames}) }}";
                };
                steps = [
                  steps.checkout
                  steps.nothingButNix
                  steps.installNix
                  steps.cacheNix
                  {
                    run = ''
                      nix ${nixArgs} build '.#checks.${runner.system}."''${{ matrix.${matrixParam} }}"'
                    '';
                  }
                ];
              };
            };
          };
        }
      ];

      treefmt.settings.global.excludes = [ filePath ];
    };
}
