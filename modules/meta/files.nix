{
  inputs,
  config,
  withSystem,
  lib,
  ...
}:
{
  imports = [ inputs.files.flakeModules.default ];

  text.readme.parts.files =
    withSystem (builtins.head config.systems) (psArgs: psArgs.config.files.files)
    |> map (file: "- `${file.path_}`")
    |> lib.naturalSort
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

  perSystem = psArgs: {
    make-shells.default.packages = [ psArgs.config.files.writer.drv ];
  };
}
