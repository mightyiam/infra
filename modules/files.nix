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
        lib.types.either (lib.types.separatedString "") (
          lib.types.submodule {
            options = {
              parts = lib.mkOption {
                type = lib.types.lazyAttrsOf lib.types.str;
              };
              order = lib.mkOption {
                type = lib.types.listOf lib.types.str;
              };
            };
          }
        )
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
                filePath: file:
                pkgs.writeText "file-${filePath}" (
                  if lib.isAttrs file then
                    lib.pipe file.order [
                      (map (lib.flip lib.getAttr file.parts))
                      lib.concatStrings
                    ]
                  else
                    file
                )
              );
            };

            writer = lib.mkOption {
              type = lib.types.package;
              default = pkgs.writeShellApplication {
                name = "write-files";
                text = lib.pipe cfg.drvs [
                  (lib.mapAttrsToList (filePath: drv: "cat ${drv} > ${lib.escapeShellArg filePath}"))
                  (lib.concat [ ''cd "$(git rev-parse --show-toplevel)"'' ])
                  lib.concatLines
                ];
              };
              readOnly = true;
            };
          };
        };
        config.checks = lib.flip lib.mapAttrs' cfg.drvs (
          filePath: drv: {
            name = "files/${filePath}";
            value =
              pkgs.runCommand "check-file-${filePath}"
                {
                  nativeBuildInputs = [ pkgs.difftastic ];
                }
                ''
                  difft --exit-code --display inline ${drv} ${self + "/${filePath}"}
                  touch $out
                '';
          }
        );
      }
    );
  };
}
