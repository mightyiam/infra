{
  flake.modules.homeManager.home.programs.zsh.syntaxHighlighting = {
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
