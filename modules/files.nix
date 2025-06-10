{
  flake-parts-lib,
  lib,
  config,
  self,
  ...
}:
{
  options = {
    files = lib.mkOption {
      default = { };
      type = lib.types.lazyAttrsOf (
        lib.types.submodule (smArgs: {
          options = {
            parts = lib.mkOption {
              default = { };
              type = lib.types.lazyAttrsOf lib.types.str;
            };
            order = lib.mkOption {
              default = lib.attrNames smArgs.config.parts;
              type = lib.types.listOf lib.types.str;
            };
          };
        })
      );
    };

    perSystem = flake-parts-lib.mkPerSystemOption (
      psArgs@{ pkgs, ... }:
      let
        cfg = psArgs.config.files;
      in
      {
        options = {
          files = {
            drvs = lib.mkOption {
              type = lib.types.lazyAttrsOf lib.types.package;
              readOnly = true;
              default = lib.flip lib.mapAttrs config.files (
                path:
                { parts, order }:
                lib.pipe order [
                  (map (lib.flip lib.getAttr parts))
                  lib.concatStrings
                  (pkgs.writeText "file-${path}")
                ]
              );
            };

            writer = lib.mkOption {
              type = lib.types.package;
              default = pkgs.writeShellApplication {
                name = "write-files";
                text = lib.pipe cfg.drvs [
                  (lib.mapAttrsToList (path: drv: "cat ${drv} > ${lib.escapeShellArg path}"))
                  (lib.concat [ ''cd "$(git rev-parse --show-toplevel)"'' ])
                  lib.concatLines
                ];
              };
              readOnly = true;
            };
          };
        };
        config.checks = lib.flip lib.mapAttrs' cfg.drvs (
          path: drv: {
            name = "files/${path}";
            value =
              pkgs.runCommand "check-file-${path}"
                {
                  nativeBuildInputs = [ pkgs.difftastic ];
                }
                ''
                  difft --exit-code --display inline ${drv} ${self + "/" + path}
                  touch $out
                '';
          }
        );
      }
    );
  };
}
