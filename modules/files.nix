{
  flake-parts-lib,
  lib,
  self,
  ...
}:
{
  options.perSystem = flake-parts-lib.mkPerSystemOption (
    psArgs@{ pkgs, ... }:
    let
      cfg = psArgs.config.files;
    in
    {
      options = {
        files = {
          files = lib.mkOption {
            type = lib.types.listOf (
              lib.types.submodule {
                options = {
                  path_ = lib.mkOption {
                    type = lib.types.singleLineStr;
                  };
                  drv = lib.mkOption {
                    type = lib.types.package;
                  };
                };
              }
            );
          };

          writer = lib.mkOption {
            type = lib.types.package;
            default = pkgs.writeShellApplication {
              name = "write-files";
              text = lib.pipe cfg.files [
                (map ({ path_, drv }: "cat ${drv} > ${lib.escapeShellArg path_}"))
                (lib.concat [ ''cd "$(git rev-parse --show-toplevel)"'' ])
                lib.concatLines
              ];
            };
            readOnly = true;
          };
        };
      };
      config.checks = lib.pipe cfg.files [
        (map (
          { path_, drv }:
          {
            name = "files/${path_}";
            value =
              pkgs.runCommand "check-file-${path_}"
                {
                  nativeBuildInputs = [ pkgs.difftastic ];
                }
                ''
                  difft --exit-code --display inline ${drv} ${self + "/${path_}"}
                  touch $out
                '';
          }
        ))
        lib.listToAttrs
      ];
    }
  );
}
