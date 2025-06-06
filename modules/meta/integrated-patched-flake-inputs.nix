{ lib, ... }:
{
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
}
