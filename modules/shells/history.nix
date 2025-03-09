{
  flake.modules.homeManager.home.programs.zsh = {
    history.ignorePatterns = [ "rm *" ];
    initExtra = ''
      bindkey '^[;' up-line-or-search
      bindkey '^r' history-incremental-search-backward
    '';
  };
}
