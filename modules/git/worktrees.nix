{ withSystem, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        git-dir = pkgs.writeShellApplication {
          name = "git-dir";
          runtimeInputs = [ pkgs.git ];
          text = ''
            git_dir=$(git rev-parse --git-dir)
            echo "''${git_dir%/*/*}"
          '';
        };
        git-worktree-add = pkgs.writeShellApplication {
          name = "git-worktree-add";
          runtimeInputs = [ pkgs.git ];
          text = ''
            cd "$1"
            worktree_path="$HOME/worktrees/$2"
            git worktree add --detach "$worktree_path"
            echo "$worktree_path"
          '';
        };
      };
    };

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = withSystem pkgs.system (
        psArgs: with psArgs.config.packages; [
          git-dir
          git-worktree-add
        ]
      );
    };
}
