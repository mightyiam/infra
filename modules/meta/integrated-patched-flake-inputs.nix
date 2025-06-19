{ lib, ... }:
{
  text.readme.parts.ifdi =
    # markdown
    ''
      ## Integrated patched flake inputs pattern

      - 🪶 edit/patch the repo's inputs without leaving its clone directory
      - 🕺 no `--override-input` flag; less typing and avoids confusion in case omitted
      - 🐬 single-repo setup; less to keep track of, more self-contained
      - ⚡ provided scripts save time and produce consistency
      - 😮‍💨 some mental and operational overhead such as an occasional `git submodule update`

      I attempt to maintain an upstream-first approach.
      That means contributing my changes to inputs upstream.
      While collaborating with upstream on the refinement and merge of those changes
      I maintain a branch of that input with those changes cherry-picked.
      I call these branches _integrated patched flake inputs_ (IPFIs).

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

      ### Creating an IPFI

      An IPFI is created by running `ipfi-add <input> <upstream-url> <rev> <base-ref>`.

      - `input`: name of the flake input
      - `upstream-url`: git URL of the upstream repo
      - `rev`: upstream rev to branch from
      - `base-ref`: base ref for future rebasing, such as `main`

      > [!TIP]
      > The `rev` should probably be the one to which that input is currently locked.
      > Run `nix flake metadata` to see what rev that is.

      For example

      ```console-session
      $ ipfi-add flake-parts https://github.com/hercules-ci/flake-parts 64b9f2c2df31bb87bdd2360a2feb58c817b4d16c
      ```

      And you end up with a git submodule at `./patched-inputs/<input>`.
      It can be used this way:

      ```nix
      {
        inputs.flake-parts.url = "./patched-inputs/flake-parts";
      }
      ```

      > [!TIP]
      > You might need to work around git push limits
      > such as [GitHub's](https://docs.github.com/en/get-started/using-git/troubleshooting-the-2-gb-push-limit).

      ### Cherry picking for an IPFI

      1. `cd patched-inputs/<input>`
      1. Get on the `patched-inputs/<input>` branch.
      1. Add a remote for a fork and cherry-pick from it.
      1. Make sure to push.

      ### Rebasing an IPFI

      To rebase an IPFI (or run into a conflict):
      `ipfi-rebase <input>`

      For example

      ```
      $ ipfi-rebase flake-parts
      ```

      ## Unfree packages

      What Nixpkgs unfree packages are allowed is configured at the flake level via an option.
      That is then used in the configuration of Nixpkgs used in NixOS, Home Manager or elsewhere.
      See definition at [`unfree-packages.nix`](modules/unfree-packages.nix).
      See usage at [`steam.nix`](modules/steam.nix).
      Value of this option available as flake output:

      ```console
      $ nix eval .#meta.nixpkgs.allowedUnfreePackages
      [ "steam" "steam-unwrapped" "nvidia-x11" "nvidia-settings" ]
      ```

      ## Refactoring

      To help determine whether a Nix change results in changes to derivations,
      a package `.#all-check-store-paths` builds a TOML file that maps from `.#checks`:

      ```toml
      default-shell = "/nix/store/9nx7s96vwz2h384zm8las332cbkqdszf-nix-shell"
      "nixosConfigurations/termitomyces" = "/nix/store/33iv0fagxiwfbzb81ixypn14vxl6s468-nixos-system-termitomyces-25.05.20250417.ebe4301"
      "packages/nixvim" = "/nix/store/p2rrqir5ig2v4wb3whvb8y0fmdc0kmhk-nixvim"
      ```

      > [!NOTE]
      > Implemented in [`meta/all-check-store-paths`](modules/meta/all-check-store-paths.nix)

    '';

  perSystem =
    { pkgs, ... }:
    let
      prefix = "patched-inputs";
      dotUpstreamUrl = ".upstream-url";
      dotBaseRef = ".base-ref";

      # Ideally not hard-coded but `git submodule add` does not allow setting remote name
      origin = "origin";

      # Seems okay to hardcode
      upstream = "upstream";

      ensure-upstream = pkgs.writeShellApplication {
        name = "ensure-upstream";
        runtimeInputs = [ pkgs.git ];
        text = ''
          path="$1"
          remote_url="$( <"$path${dotUpstreamUrl}" )"
          cd "$path"
          if ! git remote get-url ${upstream} > /dev/null 2>&1; then
            git remote add ${upstream} "$remote_url"
          fi
        '';
      };
    in
    {
      treefmt.settings.global.excludes = [ "${prefix}/*" ];

      make-shells.default.packages = [
        (pkgs.writeShellApplication {
          name = "ipfi-add";
          runtimeInputs = [ pkgs.git ];
          text = ''
            set -x
            path="${prefix}/$1"
            branch="${prefix}/$1"
            upstream_url="$2"
            rev="$3"
            base_ref="$4"
            cd "$(git rev-parse --show-toplevel)"
            git submodule add "./." "$path"
            echo -n "$upstream_url" > "$path${dotUpstreamUrl}"
            echo -n "$base_ref" > "$path${dotBaseRef}"
            ${lib.getExe ensure-upstream} "$path"
            cd "$path"
            git fetch ${upstream} "$rev"
            git switch -c "$branch" "$rev"
            git push --set-upstream ${origin} "$branch"
          '';
        })
        (pkgs.writeShellApplication {
          name = "ipfi-rebase";
          runtimeInputs = [ pkgs.git ];
          text = ''
            set -x
            path="${prefix}/$1"
            branch="${prefix}/$1"
            base_ref="$( <"$path${dotBaseRef}" )"
            cd "$(git rev-parse --show-toplevel)"
            ${lib.getExe ensure-upstream} "$path"
            cd "$path"
            git fetch ${origin}
            git switch "$branch"
            git fetch ${upstream} "$base_ref"
            git rebase "${upstream}/$base_ref"
            git push -f ${origin} "$branch:$branch"
          '';
        })
      ];
    };

  flake.modules.nixos.pc = nixosArgs: {
    system = {
      nixos = {
        label = "pure";
        version = "pure";
      };
      tools.nixos-version.enable = false;
    };
  };
}
