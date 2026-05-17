{ config, lib, ... }:
{
  options.gitignore = lib.mkOption {
    type = lib.types.listOf lib.types.str;
  };

  config.perSystem =
    { pkgs, ... }:
    {
      files.files = [
        {
          path = ".gitignore";
          drv = config.gitignore |> lib.naturalSort |> lib.concatLines |> pkgs.writeText ".gitignore";
        }
      ];

      treefmt.settings.global.excludes = [ "*/.gitignore" ];
    };
}
