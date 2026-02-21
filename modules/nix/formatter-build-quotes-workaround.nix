# https://github.com/NixOS/nix/pull/15030
{
  flake.modules.homeManager.base =
    hmArgs@{ pkgs, ... }:
    {
      home.packages = [
        (pkgs.writers.writeNuBin "nix" ''
          let real_nix = "${pkgs.lib.getExe hmArgs.config.nix.package}"

          def main --wrapped [...args] {
            let is_formatter_build = ($args | window 2 --stride 1 | any {|pair|
              $pair.0 == "formatter" and $pair.1 == "build"
            })

            if $is_formatter_build {
              let result = (run-external $real_nix ...$args | complete)

              let err = $result.stderr | default ""
              if $err != "" {
                print $err --stderr
              }

              let out = $result.stdout | default "" | str trim | str trim -c '"'
              print $out

              if $result.exit_code != 0 {
                exit $result.exit_code
              }
            } else {
              run-external $real_nix ...$args
            }
          }
        '')
      ];
    };
}
