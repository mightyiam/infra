{
  perSystem =
    { pkgs, ... }:
    {
      treefmt.settings.global.excludes = [ "forks/*" ];

      packages.input-forks-rebase = pkgs.writeShellApplication {
        name = "input-forks-rebase";
        runtimeInputs = [ pkgs.git ];
        text = ''
          git submodule foreach "git switch \$name && git fetch upstream && git rebase upstream/HEAD && git push -f"
        '';
      };
    };
}
