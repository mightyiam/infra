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
  text.readme.parts.banner =
    # markdown
    ''
      ![Sci-fi looking server room](${banner})

    '';

  perSystem.treefmt.settings.global.excludes = [banner];
}
