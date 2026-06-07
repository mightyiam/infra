{config, ...}: {
  text.readme = {
    order = [
      "banner"
      "ci-badge"
      "intro"
      "dendritic"
      "automatic-import"
      "files"
      "all-check-store-paths"
      "github-actions"
      "disallow-warnings"
    ];

    parts.intro =
      # markdown
      ''
        # ${config.repository.git.owner}/${config.repository.git.name}

        ${config.repository.git.owner}'s [Nix](https://nix.dev)-powered "IT infrastructure" repository

        > [!NOTE]
        > I hope you find this helpful.
        > If you have any questions or suggestions for me, feel free to use the discussions feature or contact me.

      '';
  };

  perSystem = {
    files.file."README.md".text = config.text.readme;
  };
}
