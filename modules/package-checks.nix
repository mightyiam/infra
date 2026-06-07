{lib, ...}: {
  perSystem = {self', ...}: {
    checks =
      self'.packages
      |> lib.filterAttrs (name: package: package.flakeCheck or true)
      |> lib.mapAttrs' (name: package: lib.nameValuePair "packages:${name}" package);
  };
}
