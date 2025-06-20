{
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
            ### `ipfi-init-<INPUT> <REV>`

            Initializes IPFI `INPUT` at `REV`.

            > [!TIP]
            > `REV` should probably be the one to which that input is currently locked.
            > Run `nix flake metadata` to see what rev that is.

            For example

            ``` console-session
            $ ipfi-init-flake-parts 64b9f2c2df31bb87bdd2360a2feb58c817b4d16c
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
      ipfi = {
        commands = lib.pipe cfg.inputs [
          lib.attrVals
          (map (
            {
              name,
              upstream,
              path_,
              branch,
            }:
            let
              ensure-upstream = pkgs.writeShellApplication {
                name = "ensure-upstream";
                runtimeInputs = [ pkgs.git ];
                text = ''
                  cd "${path_}"
                  if ! git remote get-url ${upstream.name} > /dev/null 2>&1; then
                    git remote add ${upstream.name} "${upstream.url}"
                  fi
                '';
              };
            in
            [
              (pkgs.writeShellApplication {
                name = "ipfi-init-${name}";
                runtimeInputs = [ pkgs.git ];
                text = ''
                  set -o xtrace
                  rev="$1"
                  toplevel=$(git rev-parse --show-toplevel)
                  cd "$toplevel"
                  git submodule add "./." "${path_}"
                  cd "${path_}"
                  ${lib.getExe ensure-upstream}
                  git fetch ${upstream.name} "$rev"
                  git switch -c "${branch}" "$rev"
                  git push --set-upstream ${remoteName} "${branch}"
                '';
              })

              (pkgs.writeShellApplication {
                name = "ipfi-rebase-${name}";
                runtimeInputs = [ pkgs.git ];
                text = ''
                  set -o xtrace
                  toplevel=$(git rev-parse --show-toplevel)
                  cd "$toplevel"
                  cd "${path_}"
                  ${lib.getExe ensure-upstream}
                  git fetch ${remoteName}
                  git switch "${branch}"
                  git fetch ${upstream.name} "${upstream.ref}"
                  git rebase "${upstream.name}/${upstream.ref}"
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
