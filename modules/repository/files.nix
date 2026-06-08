{
  inputs,
  config,
  withSystem,
  lib,
  ...
}: {
  imports = [(inputs.files + "/flake-module.nix")];

  # TODO this should be perSystem, apparently
  options.text = lib.mkOption {
    default = {};
    type = lib.types.lazyAttrsOf (
      lib.types.oneOf [
        (lib.types.separatedString "")
        (lib.types.submodule {
          options = {
            parts = lib.mkOption {
              type = lib.types.lazyAttrsOf lib.types.str;
            };
            order = lib.mkOption {
              type = lib.types.listOf lib.types.str;
            };
          };
        })
      ]
    );
    apply = lib.mapAttrs (
      name: text:
        if lib.isAttrs text
        then
          lib.pipe text.order [
            (map (lib.flip lib.getAttr text.parts))
            lib.concatStrings
          ]
        else text
    );
  };

  config = {
    flake-file.inputs.files = {
      url = "github:mightyiam/files";
      flake = false;
    };

    perSystem = psArgs: {
      treefmt.settings.global.excludes = lib.attrNames psArgs.config.files.file;
      files.writer.app = true;
    };

    text.readme.parts.files =
      withSystem (builtins.head config.systems) (psArgs: psArgs.config.files.file)
      |> lib.mapAttrsToList (path: _: "- `${path}`")
      |> lib.concat [
        # markdown
        ''
          ## Generated files

          The following files in this repository are generated and checked
          using [the _files_ flake-parts module](https://github.com/mightyiam/files):
        ''
      ]
      |> lib.concatLines
      |> (s: s + "\n");
  };
}
