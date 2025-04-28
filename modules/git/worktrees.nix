{ lib, ... }:
{
  flake.modules.homeManager.base.programs.zsh.initContent = lib.mkMerge [
    # cd from worktree into clone
    ''
      git-cd () {
        git_dir="$(git rev-parse --git-dir)"
        cd "''${git_dir%/*/*}"
      }
    ''

    # create a new worktree by name and cd into it
    ''
      worktree-add () {
        cd "$1" && \
        worktree_path="$HOME/worktrees/$2" && \
        git --bare worktree add --detach "$worktree_path" && \
        cd "$worktree_path"
      }
    ''
  ];
}
