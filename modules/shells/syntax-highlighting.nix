{
  flake.modules.homeManager.base.programs.zsh.syntaxHighlighting = {
    enable = true;
    highlighters = [
      "main"
      "brackets"
      "pattern"
      "regexp"
      "cursor"
      "line"
    ];
  };
}
