{ inputs, lib, ... }:
{
  flake.meta.inputs = inputs |> lib.mapAttrs (name: value: lib.break value.url);

  perSystem =
    { pkgs, ... }:
    let
      prefix = "forks";
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
          name="$1"
          remote_url="$( <"$name${dotUpstreamUrl}" )"
          cd "$name"
          if ! git remote get-url ${upstream} > /dev/null 2>&1; then
            git remote add ${upstream} "$remote_url"
          fi
        '';
      };
    in
    {
      treefmt.settings.global.excludes = [ "${prefix}/*" ];

      packages = {
        input-fork-add = pkgs.writeShellApplication {
          name = "input-fork-add";
          runtimeInputs = [ pkgs.git ];
          text = ''
            set -x
            name="${prefix}/$1"
            upstream_url="$2"
            rev="$3"
            base_ref="$4"
            cd "$(git rev-parse --show-toplevel)"
            git submodule add "./." "$name"
            echo -n "$upstream_url" > "$name${dotUpstreamUrl}"
            echo -n "$base_ref" > "$name${dotBaseRef}"
            ${lib.getExe ensure-upstream} "$name"
            cd "$name"
            git fetch ${upstream} "$rev"
            git switch -c "$name" "$rev"
            git push --set-upstream ${origin} "$name"
          '';
        };

        input-fork-rebase = pkgs.writeShellApplication {
          name = "input-fork-rebase";
          runtimeInputs = [ pkgs.git ];
          text = ''
            set -x
            name="${prefix}/$1"
            base_ref="$( <"$name${dotBaseRef}" )"
            cd "$(git rev-parse --show-toplevel)"
            ${lib.getExe ensure-upstream} "$name"
            cd "$name"
            git fetch ${origin}
            git switch "$name"
            git fetch ${upstream} "$base_ref"
            git rebase "${upstream}/$base_ref"
            git push -f ${origin} "$name:$name"
          '';
        };
      };
    };
}
