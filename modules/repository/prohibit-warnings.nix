{
  text.readme.parts.prohibit-warnings = ''
    ## Trying to disallow warnings

    This at the top level of the `flake.nix` file:

    ```nix
    nixConfig.abort-on-warn = true;
    ```

    > [!NOTE]
    > It does not currently catch all warnings Nix can produce, but perhaps only evaluation warnings.
  '';
}
