{
  lib,
  removeStorePathPrefix,
  ...
}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: let
    name = "all-check-store-paths";
  in {
    packages.${name} =
      self'.checks
      |> lib.mapAttrs (_: check: builtins.unsafeDiscardStringContext check)
      |> pkgs.writers.writeTOML "${name}.toml"
      |> (toml: toml // {flakeCheck = false;});

    text.readme.parts.all-check-store-paths =
      # markdown
      ''
        ## Refactoring

        To help determine whether a Nix change results in changes to derivations,
        a package `.#all-check-store-paths` builds a TOML file that maps from `.#checks`:

        ```toml
        default-shell = "/nix/store/9nx7s96vwz2h384zm8las332cbkqdszf-nix-shell"
        "nixosConfigurations/termitomyces" = "/nix/store/33iv0fagxiwfbzb81ixypn14vxl6s468-nixos-system-termitomyces-25.05.20250417.ebe4301"
        "packages/nixvim" = "/nix/store/p2rrqir5ig2v4wb3whvb8y0fmdc0kmhk-nixvim"
        ```

        > [!NOTE]
        > Implemented in `${removeStorePathPrefix __curPos.file}`.

      '';
  };
}
