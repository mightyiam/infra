{
  text.readme.parts.auto-import = ''
    ## Automatic import

    Nix files (they're all flake-parts modules) are automatically imported.
    Nix files prefixed with an underscore are ignored.
    No literal path imports are used.
    This means files can be moved around and nested in directories freely.

    > [!NOTE]
    > This pattern has been the inspiration of [an auto-imports library, import-tree](https://github.com/vic/import-tree).

  '';
}
