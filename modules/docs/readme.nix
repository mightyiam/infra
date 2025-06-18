{ config, ... }:
{
  text.readme = {
    order = [
      "logo"
      "ci"
      "intro"
      "dendritic"
      "nixos-configurations"
      "automatic-import"
      "files"
      "named-modules-as-needed"
      "ifdi"
      "flake-inputs-dedupe-prefix"
      "disallow-warnings"
    ];

    parts.intro =
      # markdown
      ''
        # Shahar "Dawn" Or (mightyiam)'s personal Nix-powered IT infrastructure repository

        > [!NOTE]
        > If you have any questions or suggestions for me, please use the discussions feature or contact me.
        > I hope you find this helpful.

      '';
  };

  perSystem =
    { pkgs, ... }:
    {
      files.files = [
        {
          path_ = "README.md";
          drv = pkgs.writeText "README.md" config.text.readme;
        }
      ];
    };
}
