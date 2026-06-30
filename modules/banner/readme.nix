{
  lib,
  removeStorePathPrefix,
  ...
}: let
  banner =
    __curPos.file
    |> removeStorePathPrefix
    |> lib.splitString "/"
    |> lib.lists.dropEnd 1
    |> lib.flip lib.concat ["image.jpg"]
    |> lib.concatStringsSep "/";
in {
  perSystem = {
    text.readme.parts.banner =
      # markdown
      ''
        ![Sci-fi looking server room](${banner})

      '';
    treefmt.settings.global.excludes = [banner];
  };
}
