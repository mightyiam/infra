{
  files.files."README.md" = {
    order = [
      "top"
      "dendritic"
      "nixos-configurations"
      "automatic-import"
      "named-modules-as-needed"
      "ifdi"
      "flake-inputs-dedupe-prefix"
      "disallow-warnings"
    ];

    parts.top =
      # markdown
      ''
        # Shahar "Dawn" Or (mightyiam)'s personal Nix-powered IT infrastructure repository

        > [!NOTE]
        > If you have any questions or suggestions for me, please use the discussions feature or contact me.
        > I hope you find this helpful.

      '';
  };
}
