{
  inputs,
  lib,
  flake-parts-lib,
  config,
  ...
}:
let
  cfg = config.ipfi;
in
{
  options = {
    ipfi = {
      nixosModule = lib.mkOption {
        type = lib.types.deferredModule;
        readOnly = true;
        description = ''
          By default NixOS uses git metadata in some derivations.
          That might not be a problem when Nixpkgs is a "normal" input.
          But when Nixpkgs is a path type input then the git metadata
          is no longer of the Nixpkgs repository
          but of the parent repository.
          That is unintended behavior and extraneous derivation change.

          This NixOS module disables these impurities
          at the cost of the absence of some version information.
        '';
        default = {
          system = {
            nixos = {
              label = "pure";
              version = "pure";
            };
            tools.nixos-version.enable = false;
          };
        };
      };

      baseDir = lib.mkOption {
        type = lib.types.str;
        description = ''
          Directory relative to Git top-level for IPFI git submodules.
        '';
        readOnly = true;
        default = "patched-inputs";
      };

      inputs = lib.mkOption {
        example =
          lib.literalExpression
            # nix
            ''
              {
                nixpkgs.upstream = {
                  url = "https://github.com/NixOS/nixpkgs.git";
                  ref = "nixpkgs-unstable";
                };
                home-manager.upstream = {
                  url = "https://github.com/nix-community/home-manager.git";
                  ref = "master";
                };
              }
            '';
        type = lib.types.lazyAttrsOf (
          lib.types.submodule (
            { name, ... }:
            {
              options = {
                name = lib.mkOption {
                  type = lib.types.str;
                  readOnly = true;
                  description = ''
                    Name of input.
                  '';
                  example = lib.literalExpression ''"flake-parts"'';
                };

                upstream = {
                  url = lib.mkOption {
                    type = lib.types.str;
                    example = lib.literalExpression ''"https://github.com/nix-community/stylix.git"'';
                    description = ''
                      remote URL of the upstream Git repo.
                    '';
                  };
                  ref = lib.mkOption {
                    type = lib.types.str;
                    description = ''
                      ref of the upstream Git repo.
                    '';
                    example = lib.literalExpression ''"master"'';
                  };
                  name = lib.mkOption {
                    readOnly = true;
                    type = lib.types.str;
                    default = "upstream";
                    description = ''
                      Remote upstream name.
                    '';
                  };
                };
                path_ = lib.mkOption {
                  type = lib.types.str;
                  readOnly = true;
                  description = ''
                    Path of IPFI Git submodule relative to Git top-level.
                  '';
                };
                branch = lib.mkOption {
                  type = lib.types.str;
                  readOnly = true;
                  description = ''
                    IPFI branch.
                  '';
                };
              };
              config = {
                inherit name;
                path_ = "${cfg.baseDir}/${name}";
                branch = "patched-inputs/${name}";
              };
            }
          )
        );
      };
    };
    perSystem = flake-parts-lib.mkPerSystemOption {
      options.ipfi = {
        commands = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          readOnly = true;
          # TODO DRY out
          description = ''
            ### `ipfi-init-<INPUT>`

            Initializes IPFI `INPUT` at its current revision.

            For example

            ``` console-session
            $ ipfi-init-flake-parts
            ```

            And you end up with a git submodule at `./patched-inputs/flake-parts`.
            It can be used this way:

            ```nix
            {
              inputs.flake-parts.url = "./patched-inputs/flake-parts";
            }
            ```

            > [!TIP]
            > With repositories with huge history such as Nixpkgs
            > you might need to work around git push limits
            > such as [GitHub's](https://docs.github.com/en/get-started/using-git/troubleshooting-the-2-gb-push-limit).

            ### `ipfi-rebase-<INPUT>`

            Attempt to rebase an IPFI.

            For example

            ``` console-session
            $ ipfi-rebase-flake-parts
            ```

          '';
        };
      };
    };
  };

  config.perSystem =
    { pkgs, ... }:
    let
      # This can probably be wrong in some cases
      remoteName = "origin";
    in
    {
      files.files = [
        {
          path_ = "modules/ipfi/README.md";
          drv = pkgs.writeText "ipfi-README.md" ''
            - 🪶 edit/patch the repo's inputs without leaving its clone directory
            - 🕺 no `--override-input` flag; less typing and avoids confusion in case omitted
            - 🐬 single-repo setup; less to keep track of, more self-contained
            - ⚡ provided scripts save time and produce consistency
            - 😮‍💨 some mental and operational overhead such as an occasional `git submodule update`

            IPFIs are stored in this very repository.
            Yes, even though they are branches from disparate repositories,
            they are stored in the repository in which they are used.
            Git doesn't mind.

            For each IPFI a git submodule exists.
            That submodule is a clone of this very same repository.
            The head of that submodule is set to the head of the IPFI branch.

            Finally, each `inputs.<name>.url` value is a path to the corresponding IPFI submodule directory.

            > [!WARNING]
            > There seems to be an issue with Nix that affects the IPFI pattern.
            > Workaround: artificially make the repository dirty.

            Documentation: see the implementation and usage in this directory.

            How to cherry pick for an IPFI:

            1. `cd patched-inputs/<input>`
            1. Get on the `patched-inputs/<input>` branch.
            1. Add a remote for a fork and cherry-pick from it.
            1. Make sure to push.
          '';
        }
      ];

      ipfi = {
        commands = lib.pipe cfg.inputs [
          lib.attrValues
          (map (
            {
              name,
              upstream,
              path_,
              branch,
            }:
            let
              cdToplevel = ''
                toplevel=$(git rev-parse --show-toplevel)
                cd "$toplevel"
              '';
              ensure-upstream = ''
                if ! git remote get-url ${upstream.name} > /dev/null 2>&1; then
                  git remote add ${upstream.name} "${upstream.url}"
                fi
              '';
            in
            (lib.optional (inputs.${name} ? rev) (
              pkgs.writeShellApplication {
                name = "ipfi-init-${name}";
                runtimeInputs = [ pkgs.git ];
                text = ''
                  set -o xtrace
                  ${cdToplevel}
                  git submodule add "./." "${path_}"
                  cd "${path_}"
                  ${ensure-upstream}
                  git fetch ${upstream.name} "${inputs.${name}.rev}"
                  git switch -c "${branch}" "${inputs.${name}.rev}"
                  git push --set-upstream ${remoteName} "${branch}"
                '';
              }
            ))
            ++ [
              (pkgs.writeShellApplication {
                name = "ipfi-rebase-${name}";
                runtimeInputs = [ pkgs.git ];
                text = ''
                  set -o xtrace
                  ${cdToplevel}
                  cd "${path_}"
                  ${ensure-upstream}
                  git fetch ${remoteName}
                  git switch "${branch}"
                  git fetch ${upstream.name} "${upstream.ref}"
                  git rebase "${upstream.name}/${upstream.ref}"
                '';
              })
              (pkgs.writeShellApplication {
                name = "ipfi-push-${name}";
                runtimeInputs = [ pkgs.git ];
                text = ''
                  set -o xtrace
                  ${cdToplevel}
                  cd "${path_}"
                  ${ensure-upstream}
                  git push -f ${remoteName} "${branch}:${branch}"
                '';
              })
            ]
          ))
          lib.flatten
        ];
      };
    };
}
