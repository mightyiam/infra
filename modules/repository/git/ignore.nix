{
  config,
  lib,
  ...
}: let
  cfg = config.git.ignore;
in {
  options.git.ignore = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    apply = lib.naturalSort;
  };

  config = {
    perSystem = {
      files.file.".gitignore".text = cfg |> lib.concatLines;

      treefmt.settings.global.excludes = ["*/.gitignore"];
    };
    git.ignore = [
      "/result"
      "/result-*"
    ];
  };
}
