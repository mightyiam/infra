{
  config,
  removeStorePathPrefix,
  ...
}: let
  filename = "check.yaml";
  filePath = ".github/workflows/${filename}";
  repository = config.repository.git;
  workflowName = "Check";
in {
  text.readme.parts = {
    ci-badge = ''
      <a href="https://github.com/${repository.owner}/${repository.name}/actions/workflows/${filename}?query=branch%3A${repository.defaultBranch}">
      <img
        alt="CI status"
        src="https://img.shields.io/${repository.forge}/actions/workflow/status/${repository.owner}/${repository.name}/${filename}?style=for-the-badge&branch=${repository.defaultBranch}&label=${workflowName}"
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

      To prevent runners from running out of space,
      The action [Nothing but Nix](https://github.com/marketplace/actions/nothing-but-nix)
      is used.

      See `${removeStorePathPrefix __curPos.file}`.

    '';
  };

  perSystem = {pkgs, ...}: {
    files.file.${filePath}.source = pkgs.writers.writeJSON "gh-actions-workflow-check.yaml" {
      name = workflowName;
      on = {
        push = {};
        workflow_call = {};
      };
      jobs = {
        check = {
          runs-on = "ubuntu-latest";
          steps = [
            {uses = "actions/checkout@main";}
            {
              uses = "wimpysworld/nothing-but-nix@main";
              "with" = {
                hatchet-protocol = "holster";
              };
            }
            {uses = "DeterminateSystems/nix-installer-action@main";}
            {uses = "DeterminateSystems/magic-nix-cache-action@main";}
            {
              run = ''
                nix --accept-flake-config flake check --print-build-logs --keep-going
              '';
            }
          ];
        };
      };
    };
  };
}
