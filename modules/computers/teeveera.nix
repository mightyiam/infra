{
  lib,
  removeStorePathPrefix,
  ...
}: {
  perSystem.treefmt.settings.global.excludes = [
    (
      __curPos.file
      |> removeStorePathPrefix
      |> lib.splitString "/"
      |> lib.lists.dropEnd 1
      |> lib.flip lib.concat ["teeveera-1920x1080.png"]
      |> lib.concatStringsSep "/"
    )
  ];
}
