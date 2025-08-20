{
  config,
  inputs,
  lib,
  rootPath,
  ...
}:
{
  text.readme.parts.patching-of-inputs =
    # markdown
    ''
      ## Patching of inputs

      I attempt to maintain an upstream-first approach.
      While collaborating with upstream on the refinement and merge of those changes
      I maintain a branch of that input with those changes cherry-picked.

      This repository is the origin of the
      [_input branches_](https://github.com/mightyiam/input-branches)
      project
      which is used here.

    '';

  imports = [ inputs.input-branches.flakeModules.default ];

  input-branches.inputs = {
    nixpkgs = {
      upstream = {
        url = "https://github.com/NixOS/nixpkgs.git";
        ref = "nixpkgs-unstable";
      };
      shallow = true;
    };
    home-manager.upstream = {
      url = "https://github.com/nix-community/home-manager.git";
      ref = "master";
    };
    stylix.upstream = {
      url = "https://github.com/nix-community/stylix.git";
      ref = "master";
    };
  };

  flake.modules.nixos.base = {
    imports = [ inputs.input-branches.modules.nixos.default ];
    nixpkgs.flake.source = lib.mkForce (rootPath + "/inputs/nixpkgs");
  };

  perSystem =
    psArgs@{ pkgs, ... }:
    {
      make-shells.default.packages = psArgs.config.input-branches.commands.all;
      treefmt.settings.global.excludes = [ "${config.input-branches.baseDir}/*" ];
      pre-commit.settings.hooks.check-submodules-pushed = {
        enable = true;
        stages = [ "pre-push" ];
        always_run = true;
        verbose = true;
        entry =
          pkgs.writeShellApplication {
            name = "check-submodules-pushed";
            runtimeInputs = [
              pkgs.git
              pkgs.gnugrep
            ];
            text =
              config.input-branches.inputs
              |> lib.attrValues
              |> map (
                { path_, ... }:
                # bash
                ''
                  (
                    unset GIT_DIR
                    cd ${path_}
                    current_commit=$(git rev-parse --quiet HEAD)
                    [ -z "$current_commit" ] && {
                      echo "Error: could not find HEAD of submodule ${path_}"
                      exit 1
                    }
                    status=$(git status --porcelain)
                    echo "$status" | grep -q . && {
                      echo "Error: submodule ${path_} not clean"
                      exit 1
                    }
                    git fetch
                    git ls-remote --heads | grep -q "$current_commit" || {
                      echo "Error: submodule ${path_} commit $current_commit is not pushed"
                      exit 1
                    }
                  )
                ''
              )
              |> lib.concat [
                ''
                  set -o xtrace
                ''
              ]
              |> lib.concatLines;
          }
          |> lib.getExe;
      };
    };
}
