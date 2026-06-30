{config, ...}: {
  perSystem = psArgs: {
    text.readme = {
      order = [
        "banner"
        "intro"
        "dendritic"
        "auto-import"
        "files"
        "all-check-store-paths"
        "prohibit-warnings"
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

    files.file."README.md".text = psArgs.config.text.readme;
  };
}
