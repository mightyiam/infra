{lib, ...}: {
  _module.args.removeStorePathPrefix = path: path |> lib.splitString "/" |> lib.lists.drop 4 |> lib.concatStringsSep "/";
}
