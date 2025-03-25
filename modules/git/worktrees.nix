{
  # cd from worktree into clone
  flake.modules.homeManager.base.programs.zsh.initExtra = ''
    git-cd () {
      git_dir="$(git rev-parse --git-dir)"
      cd "''${git_dir%/*/*}"
    }
  '';
}
